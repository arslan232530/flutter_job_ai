import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:job_board/constants/app_constant.dart';
import 'package:job_board/views/custom/custom_helper/app_style.dart';
import 'package:job_board/views/custom/custom_helper/height_spacer.dart';

class PageTwo extends StatelessWidget {
  const PageTwo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: width,
        height: height,
        color: kCharcoalGrey,
        child: Column(
          children: [
            const HeightSpacer(size: 65),
            Padding(
              padding: EdgeInsets.all(4.h),
              child: Image.asset('assets/images/PageTwo.png'),
            ),
            const HeightSpacer(size: 20),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Stable Yourself \n With Your Ability',
                  textAlign: TextAlign.center,
                  style: appstyle(30, kLight, FontWeight.w500),
                ),
                const HeightSpacer(size: 10),
                Padding(
                  padding: EdgeInsets.all(8.h),
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
