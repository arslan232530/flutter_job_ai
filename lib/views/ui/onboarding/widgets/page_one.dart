import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:job_board/constants/app_constant.dart';
import 'package:job_board/views/custom/custom_helper/app_style.dart';
import 'package:job_board/views/custom/custom_text/reusable_text.dart';
import 'package:job_board/views/custom/custom_helper/height_spacer.dart';

class PageOne extends StatelessWidget {
  const PageOne({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: width,
        height: height,
        color: kDarkBlue,
        child: Column(
          children: [
            const HeightSpacer(size: 85),
            Image.asset('assets/images/PageOne.png'),
            const HeightSpacer(size: 85),
            Column(
              children: [
                ReusableText(
                  text: 'Find Your Dream Job',
                  style: appstyle(30, kLight, FontWeight.w500),
                ),
                const HeightSpacer(size: 10),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.0.w),
                  child: Text(
                    'We help you find your dream job according to your skills,location and preference based on your career',
                    textAlign: TextAlign.center,
                    style: appstyle(16, kLight, FontWeight.normal),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
