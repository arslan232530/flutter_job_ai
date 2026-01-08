import 'package:flutter_riverpod/legacy.dart';
import 'package:job_board/controllers/jobs/singlejob/single_job_state.dart';
import 'package:job_board/models/response/jobs/single_job.dart';
import 'package:job_board/services/helpers/job_helper.dart';

class SingleJobNotifier extends StateNotifier<SingleJobState> {
  SingleJobNotifier() : super(const SingleJobState());

  Future<void> fetchJob(String id) async {
    try {
      state = state.copyWith(isLoading: true, error: null);

      final GetJobRes job = await JobHelper.getJobById(id);

      state = state.copyWith(job: job, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }
}