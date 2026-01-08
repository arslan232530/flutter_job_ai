class ApplyJobState {
  final bool isLoading;
  final String? error;
  final bool success;
  final String? chatId;

  const ApplyJobState({
    this.isLoading = false,
    this.error,
    this.success = false,
    this.chatId,
  });

  ApplyJobState copyWith({
    bool? isLoading,
    String? error,
    bool? success,
    String? chatId,
  }) {
    return ApplyJobState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      success: success ?? this.success,
      chatId: chatId ?? this.chatId,
    );
  }
}
