import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:job_board/views/custom/custom_helper/app_style.dart';
import 'package:job_board/views/custom/custom_helper/height_spacer.dart';
import 'package:job_board/views/custom/custom_text/reusable_text.dart';
import 'package:job_board/views/ui/profile/custom_helper/profile_stat_card.dart';

class ProfileAdditionalInformation extends StatelessWidget {
  const ProfileAdditionalInformation({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ReusableText(
            text: 'Additional Information',
            style: appstyle(
              18.sp,
              theme.colorScheme.onSurface,
              FontWeight.w600,
            ),
          ),

          const HeightSpacer(size: 16),

          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            crossAxisSpacing: 12.w,
            mainAxisSpacing: 12.h,
            childAspectRatio: 2,
            children: const [
              ProfileStatCard(
                title: 'Applications',
                value: '24',
                icon: Icons.send_outlined,
              ),
              ProfileStatCard(
                title: 'Interviews',
                value: '8',
                icon: Icons.video_call_outlined,
              ),
              ProfileStatCard(
                title: 'Saved Jobs',
                value: '12',
                icon: Icons.bookmark_outline,
              ),
              ProfileStatCard(
                title: 'Profile Views',
                value: '156',
                icon: Icons.remove_red_eye_outlined,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
