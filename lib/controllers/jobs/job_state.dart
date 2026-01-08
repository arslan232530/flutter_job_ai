import 'package:job_board/models/response/jobs/jobs_response.dart';

class JobState {
  final bool isLoading;
  final List<JobsResponse> jobs;
  final String? error;

  const JobState({
    this.isLoading = false,
    this.jobs = const [],
    this.error,
  });

  JobState copyWith({
    bool? isLoading,
    List<JobsResponse>? jobs,
    String? error,
  }) {
    return JobState(
      isLoading: isLoading ?? this.isLoading,
      jobs: jobs ?? this.jobs,
      error: error,
    );
  }
}