import 'dart:convert';

LoginResponseModel loginResponseModelFromJson(String str) => LoginResponseModel.fromJson(json.decode(str));

String loginResponseModelToJson(LoginResponseModel data) => json.encode(data.toJson());

class LoginResponseModel {
    bool success;
    String message;
    String token;
    User user;

    LoginResponseModel({
        required this.success,
        required this.message,
        required this.token,
        required this.user,
    });

    factory LoginResponseModel.fromJson(Map<String, dynamic> json) => LoginResponseModel(
        success: json['success'],
        message: json['message'],
        token: json['token'],
        user: User.fromJson(json['user']),
    );

    Map<String, dynamic> toJson() => {
        'success': success,
        'message': message,
        'token': token,
        'user': user.toJson(),
    };
}

class User {
    Profile profile;
    String id;

    User({
        required this.profile,
        required this.id,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        profile: Profile.fromJson(json['profile']),
        id: json['_id'],
    );

    Map<String, dynamic> toJson() => {
        'profile': profile.toJson(),
        '_id': id,
    };
}

class Profile {
    String url;
    String publicId;

    Profile({
        required this.url,
        required this.publicId,
    });

    factory Profile.fromJson(Map<String, dynamic> json) => Profile(
        url: json['url'],
        publicId: json['publicId'],
    );

    Map<String, dynamic> toJson() => {
        'url': url,
        'publicId': publicId,
    };
}