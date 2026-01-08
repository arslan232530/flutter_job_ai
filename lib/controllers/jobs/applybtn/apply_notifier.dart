import 'package:flutter_riverpod/legacy.dart';
import 'package:job_board/controllers/jobs/applybtn/apply_state.dart';
import 'package:job_board/models/request/chat/createchat.dart';
import 'package:job_board/models/request/message/sendmessage.dart';
import 'package:job_board/services/helpers/chat_helper.dart';
import 'package:job_board/services/helpers/messaging_helper.dart';

class ApplyJobNotifier extends StateNotifier<ApplyJobState> {
  ApplyJobNotifier() : super(const ApplyJobState());

  Future<void> applyAndSendMessage({
    required String agentId,
    required String jobTitle,
  }) async {
    try {
      state = state.copyWith(isLoading: true, error: null);

      final model = CreateChat(userId: agentId);
      final response = await ChatHelper.apply(model);

      if (response[0]) {
        final String chatId = response[1];

        final messageModel = SendMessage(
          content: "Hello, I'm interested in $jobTitle",
          chatId: chatId,
          receiver: agentId,
        );
        await MessagingHelper.sendMessage(messageModel);

        state = state.copyWith(isLoading: false, success: true, chatId: chatId);
      } else {
        state = state.copyWith(
          isLoading: false,
          error: 'Failed to apply for job',
        );
      }
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  void reset() {
    state = const ApplyJobState();
  }
}
