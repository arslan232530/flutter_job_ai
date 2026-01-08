import 'dart:convert';

class ProfileRes {
  bool success;
  User user;

  ProfileRes({required this.success, required this.user});

  factory ProfileRes.fromJson(Map<String, dynamic> json) =>
      ProfileRes(success: json['success'], user: User.fromJson(json['user']));

  Map<String, dynamic> toJson() => {'success': success, 'user': user.toJson()};

  ProfileRes profileResFromJson(String str) =>
      ProfileRes.fromJson(json.decode(str));

  String profileResToJson(ProfileRes data) => json.encode(data.toJson());
}

class User {
  Profile profile;
  String id;
  String username;
  String email;
  String phone;
  String location;
  bool isAdmin;
  int experience;
  String jobTitle;
  bool isAgent;
  bool aiPaid;
  List<String> skills;
  DateTime createdAt;
  DateTime updatedAt;

  User({
    required this.profile,
    required this.id,
    required this.username,
    required this.email,
    required this.phone,
    required this.location,
    required this.isAdmin,
    required this.experience,
    required this.jobTitle,
    required this.isAgent,
    required this.aiPaid,
    required this.skills,
    required this.createdAt,
    required this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    profile: Profile.fromJson(json['profile']),
    id: json['_id'],
    username: json['username'],
    email: json['email'],
    phone: json['phone'],
    location: json['location'],
    isAdmin: json['isAdmin'],
    experience: json['experience'],
    jobTitle: json['jobTitle'],
    aiPaid: json['aiPaid'] ?? false,
    isAgent: json['isAgent'],
    skills: List<String>.from(json['skills'].map((x) => x)),
    createdAt: DateTime.parse(json['createdAt']),
    updatedAt: DateTime.parse(json['updatedAt']),
  );

  Map<String, dynamic> toJson() => {
    'profile': profile.toJson(),
    '_id': id,
    'username': username,
    'email': email,
    'phone': phone,
    'location': location,
    'isAdmin': isAdmin,
    'experience': experience,
    'jobTitle': jobTitle,
    'aiPaid': aiPaid,
    'isAgent': isAgent,
    'skills': List<dynamic>.from(skills.map((x) => x)),
    'createdAt': createdAt.toIso8601String(),
    'updatedAt': updatedAt.toIso8601String(),
  };
}

class Profile {
  String url;
  String publicId;

  Profile({required this.url, required this.publicId});

  factory Profile.fromJson(Map<String, dynamic> json) =>
      Profile(url: json['url'], publicId: json['publicId']);

  Map<String, dynamic> toJson() => {'url': url, 'publicId': publicId};
}
