import 'package:flutter_riverpod/legacy.dart';
import 'package:job_board/controllers/jobs/job_notifier.dart';
import 'package:job_board/controllers/jobs/job_state.dart';

final jobProvider = StateNotifierProvider<JobNotifier, JobState>(
  (ref) => JobNotifier(),
);
