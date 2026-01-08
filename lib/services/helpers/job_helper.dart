import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:job_board/models/response/jobs/jobs_response.dart';
import 'package:job_board/models/response/jobs/single_job.dart';
import 'package:job_board/services/config.dart';

class JobHelper {
  static var client = http.Client();

  static Future<List<JobsResponse>> getJobs({
    String? search,
    String? location,
    String? company,
  }) async {
    try {
      final Map<String, String> requestHeaders = {
        'Content-Type': 'application/json',
      };

      final queryParams = {
        if (search != null && search.isNotEmpty) 'search': search,
        if (location != null && location.isNotEmpty) 'location': location,
        if (company != null && company.isNotEmpty) 'company': company,
      };

      final url = Uri.http(Config.apiUrl, Config.jobs, queryParams);

      final response = await client.get(url, headers: requestHeaders);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        final List<dynamic> jobsJson = data['jobs'];
        return jobsJson.map((job) => JobsResponse.fromJson(job)).toList();
      } else {
        throw Exception('Failed to get jobs');
      }
    } catch (e, s) {
      debugPrint('Error Occurred: $e');
      debugPrintStack(stackTrace: s);
      rethrow;
    }
  }

  static Future<GetJobRes> getJobById(String id) async {
    try {
      final url = Uri.http(Config.apiUrl, '${Config.job}$id'); // /jobs/:id
      final response = await client.get(
        url,
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        return GetJobRes.fromJson(data['job']);
      } else if (response.statusCode == 404) {
        throw Exception('Job not found');
      } else {
        throw Exception('Failed to get the job');
      }
    } catch (e, s) {
      debugPrint('Error Occurred: $e');
      debugPrintStack(stackTrace: s);
      rethrow;
    }
  }

  static Future<List<JobsResponse>> getfilterJobs(
    String? query,
    String? location,
    String? company,
  ) async {
    try {
      final Map<String, String> requestHeaders = {
        'Content-Type': 'application/json',
      };

      final url = Uri.http(Config.apiUrl, Config.jobs);
      final response = await client.get(url, headers: requestHeaders);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(
          response.body,
        ); // decode as Map
        final List<dynamic> jobsJson = data['jobs'];
        final jobsList = jobsJson
            .map((job) => JobsResponse.fromJson(job))
            .toList();
        return jobsList;
      } else {
        throw Exception('Failed to get the job');
      }
    } catch (e, s) {
      debugPrint('Error Occurred: $e');
      debugPrintStack(stackTrace: s);
      rethrow;
    }
  }
}
