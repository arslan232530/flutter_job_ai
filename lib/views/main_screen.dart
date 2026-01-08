import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:job_board/controllers/bottomnav/bottom_provider.dart';
import 'package:job_board/views/homepage.dart';
import 'package:job_board/views/ui/chat/chat_list.dart';

class MainScreen extends ConsumerWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final navState = ref.watch(bottomNavProvider);
    final navNotifier = ref.read(bottomNavProvider.notifier);

    final screens = const [
      HomeScreen(),
      ChatsList(),
    ];

    final items = <Widget>[
      Icon(Icons.home, size: 30.sp),
      Icon(Icons.chat, size: 30.sp),
    ];
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.transparent,
        color: theme.colorScheme.primary,
        buttonBackgroundColor: theme.colorScheme.secondary.withAlpha(40),
        items: items,
        onTap: navNotifier.changeIndex,
      ),
      body: screens[navState.currentIndex],
    );
  }
}
