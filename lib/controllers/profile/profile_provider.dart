import 'package:flutter_riverpod/legacy.dart';
import 'package:job_board/controllers/profile/profile_state.dart';
import 'package:job_board/controllers/profile/profiler_notifier.dart';

final profileProvider = StateNotifierProvider<ProfileNotifier, ProfileState>(
  (ref) => ProfileNotifier(ref),
);
