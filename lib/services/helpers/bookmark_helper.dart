import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:job_board/models/request/bookmark/bookmark_request.dart';
import 'package:job_board/services/config.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class BookmarkHelper {
  static var client = http.Client();

  /// Get all bookmarks for logged-in user
  static Future<List<BookmarkReq>> getBookmarks() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('ljobtoken') ?? '';

      final url = Uri.http(Config.apiUrl, Config.bookmarkUrl);
      final response = await client.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final List<dynamic> bookmarksJson = data['bookmarks'];
        return bookmarksJson.map((b) => BookmarkReq.fromJson(b)).toList();
      } else {
        throw Exception('Failed to load bookmarks');
      }
    } catch (e, s) {
      debugPrint('Error fetching bookmarks: $e');
      debugPrintStack(stackTrace: s);
      rethrow;
    }
  }

  /// Create a new bookmark
  static Future<BookmarkReq?> createBookmark(String jobId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('ljobtoken') ?? '';

      final url = Uri.http(Config.apiUrl, Config.bookmarkUrl);
      final response = await client.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({'job': jobId}),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 201) {
        return BookmarkReq.fromJson(data['bookmark']);
      } else if (response.statusCode == 400 &&
          data['message'] == 'Job already bookmarked') {
        // Optional: return null or handle differently
        debugPrint('Job already bookmarked');
        return null;
      } else {
        throw Exception(data['message'] ?? 'Failed to create bookmark');
      }
    } catch (e, s) {
      debugPrint('Error creating bookmark: $e');
      debugPrintStack(stackTrace: s);
      rethrow;
    }
  }

  /// Delete a bookmark by job ID
  static Future<void> deleteBookmark(String jobId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('ljobtoken') ?? '';

      final url = Uri.http(Config.apiUrl, '${Config.bookmarkUrl}$jobId');
      final response = await client.delete(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to delete bookmark');
      }
    } catch (e, s) {
      debugPrint('Error deleting bookmark: $e');
      debugPrintStack(stackTrace: s);
      rethrow;
    }
  }
}
