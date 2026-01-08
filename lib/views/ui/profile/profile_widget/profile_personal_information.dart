import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:job_board/models/response/auth/user_response_model.dart';
import 'package:job_board/views/custom/custom_helper/app_style.dart';
import 'package:job_board/views/custom/custom_helper/height_spacer.dart';
import 'package:job_board/views/custom/custom_helper/width_spacer.dart';
import 'package:job_board/views/custom/custom_text/reusable_text.dart';
import 'package:job_board/views/ui/profile/custom_helper/profile_info_card.dart';

class ProfilePersonalInformation extends StatelessWidget {
  final User? user; // Accept user

  const ProfilePersonalInformation({super.key, this.user});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Fallback dummy data
    final email = user?.email ?? 'alex.johnson@example.com';
    final phone = user?.phone ?? '+1 (555) 123-4567';
    final experience = user != null ? '${user!.experience}+ Years' : '5+ Years';

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ReusableText(
                text: 'Personal Information',
                style: appstyle(
                  18.sp,
                  theme.colorScheme.onSurface,
                  FontWeight.w600,
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Row(
                  children: [
                    Icon(
                      Icons.edit,
                      size: 16.sp,
                      color: theme.colorScheme.primary,
                    ),
                    const WidthSpacer(width: 4),
                    ReusableText(
                      text: 'Edit',
                      style: appstyle(
                        14.sp,
                        theme.colorScheme.primary,
                        FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const HeightSpacer(size: 16),

          // Info Cards
          ProfileInfoCard(
            icon: Icons.email_outlined,
            title: 'Email',
            value: email,
          ),

          const HeightSpacer(size: 12),

          ProfileInfoCard(
            icon: Icons.phone_outlined,
            title: 'Phone',
            value: phone,
          ),

          const HeightSpacer(size: 12),

          ProfileInfoCard(
            icon: Icons.calendar_today_outlined,
            title: 'Experience',
            value: experience,
          ),
        ],
      ),
    );
  }
}

