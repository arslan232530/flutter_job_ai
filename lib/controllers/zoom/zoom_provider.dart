import 'package:flutter_riverpod/legacy.dart';
import 'package:job_board/controllers/zoom/zoom_notifier.dart';
import 'package:job_board/controllers/zoom/zoom_state.dart';

final zoomProvider = StateNotifierProvider<ZoomNotifier, ZoomState>(
  (ref) => ZoomNotifier(),
);
