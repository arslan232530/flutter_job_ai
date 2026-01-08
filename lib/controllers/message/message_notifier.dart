import 'package:flutter_riverpod/legacy.dart';
import 'package:job_board/controllers/message/message_state.dart';
import 'package:job_board/models/request/message/sendmessage.dart';
import 'package:job_board/models/response/message/message_response.dart';
import 'package:job_board/services/helpers/messaging_helper.dart';
import 'package:job_board/services/sockets/socketservice.dart';

class MessageNotifier extends StateNotifier<MessageState> {
  MessageNotifier() : super(MessageState.initial());

  /// Fetch messages for a chat (pagination supported)
  Future<void> fetchMessages(String chatId) async {
    if (state.isLoading || !state.hasMore) return;

    state = state.copyWith(isLoading: true);

    try {
      final List<ReceivedMessage> newMessages =
          await MessagingHelper.getMessages(chatId, state.page);

      state = state.copyWith(
        messages: [...state.messages, ...newMessages],
        page: state.page + 1,
        hasMore: newMessages.length == 12,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  void icreasePageNumber() {
    state = state.copyWith(page: state.page + 1);
  }

  void addIncomingMessage(ReceivedMessage message) {
    state = state.copyWith(messages: [message, ...state.messages]);
  }

  /// Send a message
  Future<void> sendMessage({
    required String content,
    required String chatId,
    required String receiver,
  }) async {
    try {
      final model = SendMessage(
        content: content,
        chatId: chatId,
        receiver: receiver,
      );

      final result = await MessagingHelper.sendMessage(model);

      if (result[0] == true) {
        final ReceivedMessage message = result[1];
        final Map<String, dynamic> emission = result[2];

        state = state.copyWith(messages: [message, ...state.messages]);

        // Socket emit
        SocketService().emitNewMessage(emission, chatId);
      }
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  // /// Clear messages when leaving chat
  // void reset() {
  //   state = MessageState.initial();
  // }
}
