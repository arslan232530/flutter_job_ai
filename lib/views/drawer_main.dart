import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:job_board/constants/app_constant.dart';
import 'package:job_board/controllers/zoom/zoom_drawer_controller_provider.dart';
import 'package:job_board/controllers/zoom/zoom_provider.dart';
import 'package:job_board/views/custom/drawer/drawer_screen.dart';
import 'package:job_board/views/homepage.dart';
import 'package:job_board/views/main_screen.dart';
import 'package:job_board/views/ui/bookmark/bookmark_screen.dart';
import 'package:job_board/views/ui/devicemanagement/device_manage.dart';
import 'package:job_board/views/ui/profile/profile_screen.dart';
import 'package:job_board/views/ui/appearence/appearence.dart';

class DrawerMain extends ConsumerStatefulWidget {
  const DrawerMain({super.key});

  @override
  ConsumerState<DrawerMain> createState() => _DrawerMainState();
}

class _DrawerMainState extends ConsumerState<DrawerMain> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final controller = ref.read(zoomDrawerControllerProvider);
    return ZoomDrawer(
      controller: controller,
      menuScreen: const DrawerScreen(),
      mainScreen: currentScreen(),
      borderRadius: 30.r,
      showShadow: true,
      angle: 0.0,
      slideWidth: width * 0.54,
      menuBackgroundColor: theme.colorScheme.secondary,
    );
  }

  Widget currentScreen() {
    final zoom = ref.watch(zoomProvider);
    switch (zoom.currentIndex) {
      case 0:
        return const MainScreen();
      case 1:
        return const ThemeScreen();
      case 2:
        return const ProfilePage();
      case 3:
        return const BookmarkScreen();
      case 4:
        return const DeviceManagement();

      default:
        return const HomeScreen();
    }
  }
}
