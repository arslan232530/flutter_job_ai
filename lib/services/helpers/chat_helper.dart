import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:job_board/models/request/chat/createchat.dart';
import 'package:job_board/models/response/chat/getchat.dart';
import 'package:job_board/models/response/chat/initial_chat_msg.dart';
import 'package:job_board/services/config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatHelper {
  static var client = http.Client();

  static Future<List<dynamic>> apply(CreateChat model) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('ljobtoken') ?? '';

      final url = Uri.http(Config.apiUrl, Config.chatUrl);
      final response = await client.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(model.toJson()),
      );

      if (response.statusCode == 200) {
        final first = initialChatFromJson(response.body).id;

        return [true, first];
      } else {
        return [false];
      }
    } catch (e, s) {
      debugPrint('Error fetching chat: $e');
      debugPrintStack(stackTrace: s);
      rethrow;
    }
  }

  static Future<List<GetChats>> getConversations() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('ljobtoken') ?? '';

      final url = Uri.http(Config.apiUrl, Config.chatUrl);
      final response = await client.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final chats = getChatsFromJson(response.body);

        return chats;
      } else {
        throw Exception('Failed to load chats');
      }
    } catch (e, s) {
      debugPrint('Error fetching chat: $e');
      debugPrintStack(stackTrace: s);
      rethrow;
    }
  }
}
