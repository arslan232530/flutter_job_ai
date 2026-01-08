class AiAnalysisState {
  final bool isLoading;
  final Map<String, dynamic>? analysis;
  final String? error;

  const AiAnalysisState({this.isLoading = false, this.analysis, this.error});

  AiAnalysisState copyWith({
    bool? isLoading,
    Map<String, dynamic>? analysis,
    String? error,
  }) {
    return AiAnalysisState(
      isLoading: isLoading ?? this.isLoading,
      analysis: analysis ?? this.analysis,
      error: error,
    );
  }
}
