import 'package:flutter_riverpod/legacy.dart';
import 'package:job_board/controllers/jobs/singlejob/single_job_notifier.dart';
import 'package:job_board/controllers/jobs/singlejob/single_job_state.dart';

final singleJobProvider =
    StateNotifierProvider<SingleJobNotifier, SingleJobState>(
      (ref) => SingleJobNotifier(),
    );
