class ZoomState {
  final int currentIndex;

  const ZoomState({this.currentIndex = 0});

  ZoomState copyWith({int? currentIndex}) {
    return ZoomState(currentIndex: currentIndex ?? this.currentIndex);
  }
}
