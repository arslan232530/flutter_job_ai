class PersonalDetailsState {
  final String location;
  final String phone;
  final List<String> skills;
  final String jobTitle;
  final int experience;

  const PersonalDetailsState({
    required this.location,
    required this.phone,
    required this.skills,
    required this.jobTitle,
    required this.experience,
  });

  factory PersonalDetailsState.initial() {
    return const PersonalDetailsState(
      location: '',
      phone: '',
      skills: [],
      jobTitle: '',
      experience: 0,
    );
  }

  PersonalDetailsState copyWith({
    String? location,
    String? phone,
    List<String>? skills,
    String? jobTitle,
    int? experience,
  }) {
    return PersonalDetailsState(
      location: location ?? this.location,
      phone: phone ?? this.phone,
      skills: skills ?? this.skills,
      jobTitle: jobTitle ?? this.jobTitle,
      experience: experience ?? this.experience,
    );
  }
}
