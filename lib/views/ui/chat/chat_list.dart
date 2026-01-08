import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:job_board/constants/app_constant.dart';
import 'package:job_board/controllers/chat/chat_provider.dart';
import 'package:job_board/views/custom/custom_appbar/appbar.dart';
import 'package:job_board/views/custom/custom_helper/app_style.dart';
import 'package:job_board/views/custom/custom_helper/height_spacer.dart';
import 'package:job_board/views/custom/custom_text/reusable_text.dart';
import 'package:job_board/views/custom/drawer/drawer_widget/drawer_widget.dart';

class ChatsList extends ConsumerStatefulWidget {
  const ChatsList({super.key});

  @override
  ConsumerState<ChatsList> createState() => _ChatsListState();
}

class _ChatsListState extends ConsumerState<ChatsList> {
  @override
  void initState() {
    Future.microtask(() {
      ref.read(chatControllerProvider.notifier).fetchChats();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final chatState = ref.watch(chatControllerProvider);
    final theme = Theme.of(context);

    if (chatState.isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (chatState.error != null) {
      return Scaffold(body: Center(child: Text(chatState.error!)));
    }

    // 3. Empty list
    if (chatState.chats.isEmpty) {
      return const Scaffold(body: Center(child: Text('No chats found')));
    }
    final chatNotifier = ref.read(chatControllerProvider.notifier);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.h),
        child: CustomAppBar(
          text: 'Chats',
          child: Padding(
            padding: EdgeInsets.all(12.0.h),
            child: const DrawerWidget(),
          ),
        ),
      ),
      body: ListView.builder(
        padding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 0),
        itemCount: chatState.chats.length,
        itemBuilder: (context, index) {
          final chat = chatState.chats[index];
          final otherUser = chat.users.where(
            (user) => user.id != chatState.userId,
          );
          final bool noUser = otherUser.isEmpty;
          return Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: GestureDetector(
              onTap: () {
                context.push(
                  '/chatpage',
                  extra: {
                    'id': chat.id,
                    'title': otherUser.first.username,
                    'profile': otherUser.first.profile.url,
                    'user1': chat.users[0].id,
                    'user2': chat.users[1].id,
                    'myId': chatState.userId,
                  },
                );
              },
              child: Container(
                height: 80,
                width: width,
                decoration: BoxDecoration(
                  color: theme.colorScheme.secondary,
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                ),
                child: ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 4.w),
                  minLeadingWidth: 0,
                  minVerticalPadding: 0,
                  leading: CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(otherUser.first.profile.url),
                  ),
                  title: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ReusableText(
                        text: noUser ? 'EMPTYY' : otherUser.first.username,
                        style: appstyle(
                          16,
                          theme.colorScheme.onSecondary,
                          FontWeight.w600,
                        ),
                      ),
                      const HeightSpacer(size: 5),
                      ReusableText(
                        text: chat.latestMessage!.content,
                        style: appstyle(
                          16,
                          theme.colorScheme.onSurface.withValues(alpha: 0.5),
                          FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                  trailing: Padding(
                    padding: EdgeInsets.only(right: 4.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ReusableText(
                          text: chatNotifier.msgTime(chat.updatedAt.toString()),
                          style: appstyle(
                            12,
                            theme.colorScheme.onPrimary.withValues(alpha: 0.8),
                            FontWeight.normal,
                          ),
                        ),
                        Icon(
                          chat.chatName == chatState.userId
                              ? Icons.arrow_forward_rounded
                              : Icons.arrow_back,
                          color: theme.colorScheme.onPrimary,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
