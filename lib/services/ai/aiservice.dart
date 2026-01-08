import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:job_board/services/config.dart';

class AiService {
  static var client = http.Client();

  static Future<Map<String, dynamic>> analyze({
    required List<String> userSkills,
    required List<String> jobRequirements,
  }) async {
    final url = Uri.http(Config.apiUrl, Config.aiAnalyze);
    final Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    final response = await http.post(
      url,
      headers: requestHeaders,
      body: jsonEncode({
        'userSkills': userSkills,
        'jobRequirements': jobRequirements,
      }),
    );
    final decoded = json.decode(response.body);
    if (response.statusCode == 200) {
      return jsonDecode(response.body) as Map<String, dynamic>;
    } else {
      throw Exception('Failed to analyze AI: ${decoded['message']}');
    }
  }
}
