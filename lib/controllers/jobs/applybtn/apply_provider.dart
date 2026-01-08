import 'package:flutter_riverpod/legacy.dart';
import 'package:job_board/controllers/jobs/applybtn/apply_notifier.dart';
import 'package:job_board/controllers/jobs/applybtn/apply_state.dart';

final applyJobProvider = StateNotifierProvider<ApplyJobNotifier, ApplyJobState>(
  (ref) => ApplyJobNotifier(),
);
