import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

final zoomDrawerControllerProvider = Provider<ZoomDrawerController>((ref) {
  return ZoomDrawerController();
});
