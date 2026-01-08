import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:job_board/controllers/zoom/zoom_provider.dart';
import 'package:job_board/views/custom/custom_helper/app_style.dart';
import 'package:job_board/views/custom/custom_helper/width_spacer.dart';
import 'package:job_board/views/custom/custom_text/reusable_text.dart';

class DrawerScreen extends ConsumerStatefulWidget {
  const DrawerScreen({super.key});

  @override
  ConsumerState<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends ConsumerState<DrawerScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onDoubleTap: () {
        ZoomDrawer.of(context)?.toggle();
      },
      child: Scaffold(
        backgroundColor: theme.colorScheme.secondary,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            drawerItem(Icons.home, 'Home', 0, theme.colorScheme.onPrimary),
            drawerItem(
              Icons.settings,
              'Appearence',
              1,
              theme.colorScheme.onSecondary,
            ),
            drawerItem(
              Icons.person_pin,
              'Profile',
              2,
              theme.colorScheme.onSecondary,
            ),
            drawerItem(
              Icons.bookmark,
              'Bookmarks',
              3,
              theme.colorScheme.onSecondary,
            ),
            drawerItem(
              Icons.devices,
              'Logout',
              4,
              theme.colorScheme.onSecondary,
            ),
          ],
        ),
      ),
    );
  }

  Widget drawerItem(IconData icon, String text, int index, Color activeColor) {
    final zoom = ref.watch(zoomProvider);

    final isActive = zoom.currentIndex == index;
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: () {
        ref.read(zoomProvider.notifier).changeIndex(index);
        ZoomDrawer.of(context)!.close();
      },
      child: Container(
        margin: EdgeInsets.only(left: 20.w, bottom: 40.h),
        child: Row(
          children: [
            Icon(
              icon,
              color: isActive ? activeColor : theme.colorScheme.primary,
            ),
            const WidthSpacer(width: 12),
            ReusableText(
              text: text,
              style: appstyle(
                16,
                isActive ? activeColor : theme.colorScheme.onPrimaryContainer,
                FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
