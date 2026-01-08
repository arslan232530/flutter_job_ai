class ProfileUpdateReq {
  final String location;
  final String phone;
  final List<String> skills;
  final String jobTitle;
  final int experience;

  ProfileUpdateReq({
    required this.location,
    required this.phone,
    required this.skills,
    required this.jobTitle,
    required this.experience,
  });

  Map<String, dynamic> toJson() {
    return {
      'location': location,
      'phone': phone,
      'skills': skills.join(','),
      'jobTitle': jobTitle,
      'experience': experience.toString(),
    };
  }
}
