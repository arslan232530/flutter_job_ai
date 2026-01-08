import 'dart:convert';

class LoginModel {
  final String email;
  final String password;

  LoginModel({required this.email, required this.password});

  String loginModelToJson(LoginModel data) => json.encode(data.toJson());

  Map<String, dynamic> toJson() => {'email': email, 'password': password};

  LoginModel loginModelFromJson(String src) =>
      LoginModel.fromJson(json.decode(src));

  factory LoginModel.fromJson(Map<String, dynamic> data) =>
      LoginModel(email: data['email'], password: data['password']);
}
