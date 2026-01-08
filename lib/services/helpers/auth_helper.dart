import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:job_board/controllers/auth/personal/api_result_model.dart';
import 'package:job_board/models/request/auth/login_model.dart';
import 'package:job_board/models/request/auth/profile_update_model.dart';
import 'package:job_board/models/request/auth/signup_model.dart';
import 'package:job_board/models/response/auth/login_response_model.dart';
import 'package:job_board/models/response/auth/user_response_model.dart';
import 'package:job_board/services/config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthHelper {
  static var client = http.Client();

  static Future<String?> login(LoginModel loginData) async {
    final Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    final url = Uri.http(Config.apiUrl, Config.loginUrl);
    final String body = loginData.loginModelToJson(loginData);

    final response = await client.post(
      url,
      headers: requestHeaders,
      body: body,
    );

    final data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      final SharedPreferences pref = await SharedPreferences.getInstance();

      final loginResponse = loginResponseModelFromJson(response.body);

      await pref.setString('ljobtoken', loginResponse.token);
      await pref.setString('ljobuserid', loginResponse.user.id);
      await pref.setString('ljobprofile', loginResponse.user.profile.url);
      await pref.setBool('jobloggedin', true);

      return null;
    } else {
      return data['message'] ?? 'Login failed';
    }
  }

  static Future<bool> updateProfile(
    ProfileUpdateReq model, {
    File? imageFile,
  }) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('ljobtoken') ?? '';

      final uri = Uri.http(Config.apiUrl, Config.profileUrl);
      final request = http.MultipartRequest('PUT', uri);

      request.headers['Authorization'] = 'Bearer $token';
      request.headers['Accept'] = 'application/json';

      request.fields['location'] = model.location;
      request.fields['phone'] = model.phone;
      request.fields['skills'] = model.skills.join(',');
      request.fields['jobTitle'] = model.jobTitle;
      request.fields['experience'] = model.experience.toString();

      if (imageFile != null) {
        request.files.add(
          await http.MultipartFile.fromPath('profile', imageFile.path),
        );
      }

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
      
       return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  static Future<String?> signup(SignupModel signupData) async {
    final Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    final url = Uri.http(Config.apiUrl, Config.signupUrl);
    final String body = signupData.signupModelToJson(signupData);

    final response = await client.post(
      url,
      headers: requestHeaders,
      body: body,
    );

    final data = jsonDecode(response.body);

    if (response.statusCode == 201) {
      return null;
    } else {
      return data['message'] ?? 'Signup failed';
    }
  }

  /// Fetch user profile
  static Future<ApiResult<ProfileRes>> fetchProfile() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('ljobtoken') ?? '';

      final uri = Uri.http(Config.apiUrl, Config.getProfileUrl);

      final response = await http.get(
        uri,
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return ApiResult.success(ProfileRes.fromJson(data));
      }

      return ApiResult.failure(data['message'] ?? 'Failed to load profile');
    } catch (e) {
      return ApiResult.failure('Something went wrong');
    }
  }

  static Future<ApiResult<ProfileRes>> removeSkill(String skill) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('ljobtoken') ?? '';

      final uri = Uri.http(Config.apiUrl, Config.removeSkill);
      final response = await http.delete(
        uri,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({'skill': skill}),
      );

      final data = jsonDecode(response.body);
      print(data);

      if (response.statusCode == 200) {
        return ApiResult.success(ProfileRes.fromJson(data['user']));
      } else {
        return ApiResult.failure(data['message'] ?? 'Failed to remove skill');
      }
    } catch (e) {
      return ApiResult.failure('Something went wrong');
    }
  }
}
