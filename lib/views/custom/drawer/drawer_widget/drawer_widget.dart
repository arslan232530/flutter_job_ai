import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:job_board/controllers/zoom/zoom_drawer_controller_provider.dart';

class DrawerWidget extends ConsumerWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () {
        ref.read(zoomDrawerControllerProvider).toggle?.call();
      },
      child: Icon(Icons.menu, size: 30.w),
    );
  }
}
