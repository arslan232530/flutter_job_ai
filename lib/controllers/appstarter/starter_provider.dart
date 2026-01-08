import 'package:flutter_riverpod/legacy.dart';
import 'package:job_board/controllers/appstarter/starter_notifier.dart';
import 'package:job_board/controllers/appstarter/starter_state.dart';

final starterProvider = StateNotifierProvider<StarterNotifier, StarterState>(
  (ref) => StarterNotifier(),
);
