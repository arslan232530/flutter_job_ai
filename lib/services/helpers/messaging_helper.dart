import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:job_board/models/request/message/sendmessage.dart';
import 'package:job_board/models/response/message/message_response.dart';
import 'package:job_board/services/config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MessagingHelper {
  static var client = http.Client();

  static Future<List<dynamic>> sendMessage(SendMessage model) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('ljobtoken') ?? '';

      final url = Uri.http(Config.apiUrl, Config.messageUrl);
      final response = await client.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(model.toJson()),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> decoded = jsonDecode(response.body);
        final ReceivedMessage message = ReceivedMessage.fromJson(decoded);
        return [true, message, decoded];
      } else {
        return [false];
      }
    } catch (e, s) {
      debugPrint('Error fetching chat: $e');
      debugPrintStack(stackTrace: s);
      rethrow;
    }
  }

  static Future<List<ReceivedMessage>> getMessages(
    String chatId,
    int offset,
  ) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('ljobtoken') ?? '';

      final url = Uri.http(Config.apiUrl, '${Config.messageUrl}/$chatId', {
        'page': offset.toString(),
      });
      final response = await client.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final msgs = receivedMessageFromJson(response.body);
        return msgs;
      } else {
        throw Exception('Failed to load Messages');
      }
    } catch (e, s) {
      debugPrint('Error fetching Message: $e');
      debugPrintStack(stackTrace: s);
      rethrow;
    }
  }
}
