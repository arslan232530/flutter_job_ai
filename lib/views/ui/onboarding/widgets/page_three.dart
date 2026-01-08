import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:job_board/constants/app_constant.dart';
import 'package:job_board/controllers/appstarter/starter_provider.dart';
import 'package:job_board/views/custom/custom_helper/app_style.dart';
import 'package:job_board/views/custom/custom_btn/custom_outline_btn.dart';
import 'package:job_board/views/custom/custom_text/reusable_text.dart';
import 'package:job_board/views/custom/custom_helper/height_spacer.dart';

class PageThree extends ConsumerWidget {
  const PageThree({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Container(
        width: width,
        height: height,
        color: kDarkBlue,
        child: Column(
          children: [
            Image.asset('assets/images/PageThree.png'),
            const HeightSpacer(size: 35),

            ReusableText(
              text: 'Welcome to Job Portal',
              style: appstyle(30, kLight, FontWeight.w600),
            ),
            const HeightSpacer(size: 25),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.w),
              child: Text(
                'We help you find your dream job according to your skills,location and preference based on your career',
                textAlign: TextAlign.center,
                style: appstyle(16, kLight, FontWeight.normal),
              ),
            ),
            const HeightSpacer(size: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CustomOutlineBtn(
                  onTap: () async {
                    ref.read(starterProvider.notifier).completeOnboarding();
                    context.push('/login');
                  },
                  text: 'Login',
                  width: width * 0.4,
                  hieght: height * 0.06,
                  color: kLight,
                ),

                GestureDetector(
                  onTap: () async {
                    ref.read(starterProvider.notifier).completeOnboarding();
                    context.push('/signup');
                  },
                  child: Container(
                    width: width * 0.4,
                    height: height * 0.06,
                    color: kLight,
                    child: Center(
                      child: ReusableText(
                        text: 'Sign Up',
                        style: appstyle(16, kDarkBlue, FontWeight.w600),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const HeightSpacer(size: 30),
            ReusableText(
              text: 'Continue as guest',
              style: appstyle(16, kLight, FontWeight.w400),
            ),
          ],
        ),
      ),
    );
  }
}
