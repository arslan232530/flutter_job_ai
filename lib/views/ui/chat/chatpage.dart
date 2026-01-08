import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:job_board/constants/app_constant.dart';
import 'package:job_board/controllers/chat/chat_notifier.dart';
import 'package:job_board/controllers/chat/chat_provider.dart';
import 'package:job_board/controllers/message/message_notifier.dart';
import 'package:job_board/controllers/message/message_provider.dart';
import 'package:job_board/controllers/message/message_state.dart';
import 'package:job_board/services/sockets/socketservice.dart';
import 'package:job_board/views/custom/custom_appbar/appbar.dart';
import 'package:job_board/views/custom/custom_helper/app_style.dart';
import 'package:job_board/views/custom/custom_helper/height_spacer.dart';
import 'package:job_board/views/custom/custom_text/reusable_text.dart';
import 'package:job_board/views/ui/chat/helping_widget/custom_message_field.dart';

class ChatPage extends ConsumerStatefulWidget {
  const ChatPage({
    super.key,
    required this.title,
    required this.id,
    required this.profile,
    required this.user,
  });

  final String title;
  final String id;
  final String profile;
  final List<String> user;

  @override
  ConsumerState<ChatPage> createState() => _ChatPageState();
}

late MessageNotifier messageNotifier;
late ChatController chatNotifier;
late MessageState moreMessages;
String? userId;

class _ChatPageState extends ConsumerState<ChatPage> {
  TextEditingController messageController = TextEditingController();
  late ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController();

    Future.microtask(() {
      messageNotifier = ref.read(messageControllerProvider.notifier);
      chatNotifier = ref.read(chatControllerProvider.notifier);
      userId = ref.read(chatControllerProvider).userId;
      moreMessages = ref.read(messageControllerProvider);

      // Fetch messages once
      messageNotifier.fetchMessages(widget.id);

      // Connect socket ONCE
      if (userId != null) {
        SocketService().connect(
          userId!,
          chatNotifier,
          widget.id,
          messageNotifier,
        );

        SocketService().joinChat(widget.id);
      }
    });

    // Add scroll listener for pagination
    _scrollController.addListener(_handleScroll);

    super.initState();
  }

  void _handleScroll() async {
    if (!_scrollController.hasClients) return;

    if (_scrollController.position.maxScrollExtent ==
        _scrollController.position.pixels) {
      // Reached top (because reverse:true)
      if (moreMessages.hasMore) {
        await messageNotifier.fetchMessages(widget.id);
      }
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final messageState = ref.watch(messageControllerProvider);
    final chatState = ref.watch(chatControllerProvider);
    final String receiver = widget.user.firstWhere(
      (id) => id != chatState.userId,
    );

    if (messageState.isLoading && messageState.messages.isEmpty) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    if (messageState.error != null) {
      return Scaffold(body: Center(child: Text(messageState.error!)));
    }

    if (messageState.messages.isEmpty) {
      return const Scaffold(body: Center(child: Text('No messages yet')));
    }

    final theme = Theme.of(context);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.h),
        child: CustomAppBar(
          text: !chatState.typing ? widget.title : 'Typing...',
          actions: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: Stack(
                children: [
                  CircleAvatar(backgroundImage: NetworkImage(widget.profile)),
                  Positioned(
                    right: 3,
                    child: CircleAvatar(
                      radius: 5,
                      backgroundColor: chatState.onlineUsers.contains(receiver)
                          ? Colors.green
                          : theme.colorScheme.error,
                    ),
                  ),
                ],
              ),
            ),
          ],
          child: Padding(
            padding: EdgeInsets.all(12.0.h),
            child: GestureDetector(
              onTap: () {
                context.pop();
              },
              child: const Icon(Icons.arrow_back),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.h),
          child: Padding(
            padding: EdgeInsets.only(top: 8.h, bottom: 12.h),
            child: Column(
              children: [
                ReusableText(
                  text: chatNotifier.msgTime(
                    messageState.messages.first.updatedAt.toString(),
                  ),
                  style: appstyle(
                    14,
                    theme.colorScheme.onSurface,
                    FontWeight.bold,
                  ),
                ),
                const HeightSpacer(size: 15),
                Expanded(
                  child: ListView.builder(
                    controller: _scrollController,
                    reverse: true, // so new messages appear at bottom
                    itemCount: messageState.messages.length,
                    itemBuilder: (context, index) {
                      final msg = messageState.messages[index];
                      final isMe =
                          msg.sender.id ==
                          chatState.userId; // compare with current user
                      return ChatBubble(
                        margin: EdgeInsets.only(bottom: 4.h),
                        alignment: isMe
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        backGroundColor: isMe
                            ? theme.colorScheme.primary
                            : theme.colorScheme.onSurface,
                        elevation: 0,

                        clipper: ChatBubbleClipper4(
                          radius: 8,
                          type: isMe
                              ? BubbleType.sendBubble
                              : BubbleType.receiverBubble,
                        ),
                        child: Container(
                          constraints: BoxConstraints(maxWidth: width * 0.8),
                          child: ReusableText(
                            text: msg.content,
                            style: appstyle(
                              14,
                              isMe
                                  ? theme.colorScheme.onPrimary
                                  : theme.colorScheme.surface,
                              FontWeight.normal,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const HeightSpacer(size: 10),
                CustomMessageWidget(
                  controller: messageController,
                  onChanged: (text) {
                    SocketService().sendTypingEvent(widget.id);
                  },
                  onSubmitted: (text) {
                    SocketService().sendStopTypingEvent(widget.id);
                    messageNotifier.sendMessage(
                      content: messageController.text,
                      chatId: widget.id,
                      receiver: receiver,
                    );
                    messageController.clear();
                  },
                  onEditingComplete: () {
                    SocketService().sendStopTypingEvent(widget.id);
                    messageNotifier.sendMessage(
                      content: messageController.text,
                      chatId: widget.id,
                      receiver: receiver,
                    );
                    messageController.clear();
                  },
                  onTapOutside: (event) {
                    FocusManager.instance.primaryFocus?.unfocus();
                    SocketService().sendStopTypingEvent(widget.id);
                  },
                  onSendPressed: () {
                    if (messageController.text.isNotEmpty) {
                      SocketService().sendStopTypingEvent(widget.id);
                      // Send the message
                      messageNotifier.sendMessage(
                        content: messageController.text,
                        chatId: widget.id,
                        receiver: receiver,
                      );
                      messageController.clear(); // Clear text field
                    }
                  },
                  hintText: 'Send a message...',
                  showSendIcon: true,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
