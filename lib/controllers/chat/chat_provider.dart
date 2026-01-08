import 'package:flutter_riverpod/legacy.dart';
import 'package:job_board/controllers/chat/chat_notifier.dart';
import 'package:job_board/controllers/chat/chat_state.dart';

final chatControllerProvider = StateNotifierProvider<ChatController, ChatState>(
  (ref) => ChatController(),
);
