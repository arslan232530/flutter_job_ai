import 'package:flutter_riverpod/legacy.dart';
import 'package:job_board/controllers/zoom/zoom_state.dart';

class ZoomNotifier extends StateNotifier<ZoomState> {
  ZoomNotifier() : super(const ZoomState(currentIndex: 0));

  void changeIndex(int index) {
    state = state.copyWith(currentIndex: index);
  }
}
