import 'package:flutter_riverpod/legacy.dart';
import 'package:job_board/controllers/chat/chat_state.dart';
import 'package:job_board/services/helpers/chat_helper.dart';
import 'package:job_board/models/response/chat/getchat.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class ChatController extends StateNotifier<ChatState> {
  ChatController() : super(ChatState.initial()) {
    loadUserId();
  }

  // Fetch all chats
  Future<void> fetchChats() async {
    try {
      state = state.copyWith(isLoading: true, error: null);

      final List<GetChats> chats = await ChatHelper.getConversations();

      state = state.copyWith(chats: chats, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> loadUserId() async {
    final prefs = await SharedPreferences.getInstance();
    final id = prefs.getString('ljobuserid');

    state = state.copyWith(userId: id);
  }

  void setOnlineUsers(List<String> users) {
    state = state.copyWith(onlineUsers: users);
  }

  void setTypingStatus(bool isTyping) {
    state = state.copyWith(typing: isTyping);
  }

  String msgTime(String timestamp) {
    final DateTime now = DateTime.now();
    final DateTime messageTime = DateTime.parse(timestamp).toLocal();

    if (now.year == messageTime.year &&
        now.month == messageTime.month &&
        now.day == messageTime.day) {
      return DateFormat.jm().format(messageTime);
    } else if (now.year == messageTime.year &&
        now.month == messageTime.month &&
        now.day - messageTime.day == 1) {
      return 'Yesterday';
    } else {
      return DateFormat.yMEd().format(messageTime);
    }
  }
}
