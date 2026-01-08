import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:job_board/controllers/auth/login/login_provider.dart';
import 'package:job_board/controllers/onboarding/onboarding_provider.dart';
import 'package:job_board/controllers/zoom/zoom_provider.dart';
import 'package:job_board/views/custom/custom_appbar/appbar.dart';
import 'package:job_board/views/custom/custom_helper/app_style.dart';
import 'package:job_board/views/custom/custom_helper/height_spacer.dart';
import 'package:job_board/views/custom/custom_text/reusable_text.dart';
import 'package:job_board/views/custom/drawer/drawer_widget/drawer_widget.dart';
import 'package:job_board/views/ui/devicemanagement/widget/device_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DeviceManagement extends ConsumerWidget {
  const DeviceManagement({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final zoomNotifier = ref.read(zoomProvider.notifier);

    final onboardingNotifier = ref.read(onboardingProvider.notifier);

    final String date = DateTime.now().toString();
    final String loginDate = date.substring(0, 11);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.h),
        child: CustomAppBar(
          text: 'Device Management',
          child: Padding(
            padding: EdgeInsets.all(12.0.h),
            child: const DrawerWidget(),
          ),
        ),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const HeightSpacer(size: 50),
                  Text(
                    'You are logged in into your account on these devices',
                    style: appstyle(
                      16,
                      theme.colorScheme.onSurface,
                      FontWeight.normal,
                    ),
                  ),
                  const HeightSpacer(size: 50),
                  DevicesInfo(
                    date: loginDate,
                    device: 'MacBook M2',
                    ipAdress: '10.0.12.000',
                    location: 'Washington DC',
                    platform: 'Apple Webkit',
                  ),
                  const HeightSpacer(size: 50),
                  DevicesInfo(
                    date: loginDate,
                    device: 'iPhone 14',
                    ipAdress: '10.0.12.000',
                    location: 'Brooklyn',
                    platform: 'Mobile App',
                  ),
                ],
              ),
            ),

            /// Sign out action
            Padding(
              padding: EdgeInsets.all(8.0.h),
              child: GestureDetector(
                onTap: () async {
                  zoomNotifier.changeIndex(0);
                  onboardingNotifier.onPageChanged(0);
                  final loginNotifier = ref.read(loginProvider.notifier);
                  loginNotifier.logout(); // if exists

                  final SharedPreferences pref =
                      await SharedPreferences.getInstance();
                  await pref.setBool('entrypoint', false);
                },
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: ReusableText(
                    text: 'Sign out from all devices',
                    style: appstyle(
                      18,
                      theme.colorScheme.primary,
                      FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
