import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:job_board/controllers/theme/theme_provider.dart';
import 'package:job_board/views/custom/custom_appbar/appbar.dart';
import 'package:job_board/views/custom/custom_helper/app_style.dart';
import 'package:job_board/views/custom/custom_helper/height_spacer.dart';
import 'package:job_board/views/custom/custom_text/reusable_text.dart';
import 'package:job_board/views/custom/drawer/drawer_widget/drawer_widget.dart';
import 'package:job_board/views/ui/appearence/widget/appearence_widget.dart';

class ThemeScreen extends ConsumerWidget {
  const ThemeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final themeState = ref.watch(themeProvider);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.h),
        child: const CustomAppBar(text: 'Appearance', child: DrawerWidget()),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ReusableText(
              text: 'Choose Theme',
              style: appstyle(22, theme.colorScheme.primary, FontWeight.w500),
            ),
            const HeightSpacer(size: 14),

            themeTile(
              context,
              icon: Icons.light_mode,
              title: 'Light Mode',
              isActive: themeState.themeMode == ThemeMode.light,
              onTap: () {
                ref.read(themeProvider.notifier).setLightTheme();
              },
            ),
            const HeightSpacer(size: 5),
            themeTile(
              context,
              icon: Icons.dark_mode,
              title: 'Dark Mode',
              isActive: themeState.themeMode == ThemeMode.dark,
              onTap: () {
                ref.read(themeProvider.notifier).setDarkTheme();
              },
            ),
            const HeightSpacer(size: 5),
            themeTile(
              context,
              icon: Icons.settings_suggest,
              title: 'System Default',
              isActive: themeState.themeMode == ThemeMode.system,
              onTap: () {
                ref.read(themeProvider.notifier).setSystemTheme();
              },
            ),
          ],
        ),
      ),
    );
  }
}
