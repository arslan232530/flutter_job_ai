import 'package:job_board/models/response/jobs/single_job.dart';

class SingleJobState {
  final bool isLoading;
  final GetJobRes? job;
  final String? error;

  const SingleJobState({
    this.isLoading = false,
    this.job,
    this.error,
  });

  SingleJobState copyWith({
    bool? isLoading,
    GetJobRes? job,
    String? error,
  }) {
    return SingleJobState(
      isLoading: isLoading ?? this.isLoading,
      job: job ?? this.job,
      error: error,
    );
  }
}