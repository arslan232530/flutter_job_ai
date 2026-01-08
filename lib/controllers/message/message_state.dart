import 'package:job_board/models/response/message/message_response.dart';

class MessageState {
  final List<ReceivedMessage> messages;
  final bool isLoading;
  final String? error;
  final int page;
  final bool hasMore;

  MessageState({
    required this.messages,
    required this.isLoading,
    required this.page,
    required this.hasMore,
    this.error,
  });

  factory MessageState.initial() {
    return MessageState(
      messages: [],
      isLoading: false,
      page: 1,
      hasMore: true,
      error: null,
    );
  }

  MessageState copyWith({
    List<ReceivedMessage>? messages,
    bool? isLoading,
    String? error,
    int? page,
    bool? hasMore,
  }) {
    return MessageState(
      messages: messages ?? this.messages,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      page: page ?? this.page,
      hasMore: hasMore ?? this.hasMore,
    );
  }
}
