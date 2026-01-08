import 'package:flutter_riverpod/legacy.dart';
import 'package:job_board/controllers/bottomnav/bottom_state.dart';

class BottomNavNotifier extends StateNotifier<BottomNavState> {
  BottomNavNotifier() : super(const BottomNavState());

  void changeIndex(int index) {
    state = state.copyWith(currentIndex: index);
  }
}
