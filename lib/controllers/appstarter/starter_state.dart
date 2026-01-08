class StarterState {
  final bool seen; 

  StarterState({required this.seen});

  
  StarterState copyWith({bool? seen}) {
    return StarterState(seen: seen ?? this.seen);
  }
}
