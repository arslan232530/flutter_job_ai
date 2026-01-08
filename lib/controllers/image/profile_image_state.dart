class ProfileImageState {
  final String? localPath;
  final String? imageUrl;
  final bool isLoading;

  const ProfileImageState({
    this.localPath,
    this.imageUrl,
    this.isLoading = false,
  });

  ProfileImageState copyWith({
    String? localPath,
    String? imageUrl,
    bool? isLoading,
  }) {
    return ProfileImageState(
      localPath: localPath ?? this.localPath,
      imageUrl: imageUrl ?? this.imageUrl,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
