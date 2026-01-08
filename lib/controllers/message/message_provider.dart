import 'package:flutter_riverpod/legacy.dart';
import 'package:job_board/controllers/message/message_notifier.dart';
import 'package:job_board/controllers/message/message_state.dart';

final messageControllerProvider =
    StateNotifierProvider<MessageNotifier, MessageState>(
      (ref) => MessageNotifier(),
    );
