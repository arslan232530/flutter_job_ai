import 'package:job_board/models/response/chat/getchat.dart';

class ChatState {
  final List<GetChats> chats;
  final bool isLoading;
  final String? error;
  final String? userId;
  final List<String> onlineUsers;
  final bool typing;

  ChatState({
    required this.chats,
    required this.isLoading,
    required this.onlineUsers,
    required this.typing,
    this.error,
    this.userId,
  });

  factory ChatState.initial() {
    return ChatState(
      chats: [],
      isLoading: false,
      error: null,
      userId: null,
      onlineUsers: [],
      typing: false,
    );
  }

  ChatState copyWith({
    List<GetChats>? chats,
    bool? isLoading,
    String? error,
    String? userId,
    List<String>? onlineUsers,
    bool? typing,
  }) {
    return ChatState(
      chats: chats ?? this.chats,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      userId: userId ?? this.userId,
      onlineUsers: onlineUsers ?? this.onlineUsers,
      typing: typing ?? this.typing,
    );
  }
}
