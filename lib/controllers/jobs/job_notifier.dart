import 'package:flutter_riverpod/legacy.dart';
import 'package:job_board/controllers/jobs/job_state.dart';
import 'package:job_board/models/response/jobs/jobs_response.dart';
import 'package:job_board/services/helpers/job_helper.dart';

class JobNotifier extends StateNotifier<JobState> {
  JobNotifier() : super(const JobState());

  /// Fetch jobs from API
  Future<void> fetchJobs({String? search, String? location, String? company}) async {
    try {
      state = state.copyWith(isLoading: true, error: null);

      final List<JobsResponse> jobs = await JobHelper.getJobs();

      state = state.copyWith(jobs: jobs, isLoading: false);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }
}


