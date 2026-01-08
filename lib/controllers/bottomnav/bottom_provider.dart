import 'package:flutter_riverpod/legacy.dart';
import 'package:job_board/controllers/bottomnav/bottom_notifier.dart';
import 'package:job_board/controllers/bottomnav/bottom_state.dart';

final bottomNavProvider =
    StateNotifierProvider<BottomNavNotifier, BottomNavState>(
      (ref) => BottomNavNotifier(),
    );
