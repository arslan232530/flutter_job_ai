import 'package:job_board/models/response/jobs/jobs_response.dart';

class BookmarkReq {
  BookmarkReq({
    required this.id,
    required this.job,
    required this.createdAt,
    required this.updatedAt,
  });

  final String id;
  final JobsResponse job;
  final DateTime createdAt;
  final DateTime updatedAt;

  factory BookmarkReq.fromJson(Map<String, dynamic> json) => BookmarkReq(
        id: json['_id'],
        job: JobsResponse.fromJson(json['job']),
        createdAt: DateTime.parse(json['createdAt']),
        updatedAt: DateTime.parse(json['updatedAt']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'job': job.toJson(),
        'createdAt': createdAt.toIso8601String(),
        'updatedAt': updatedAt.toIso8601String(),
      };
}
