import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:job_board/controllers/auth/personal/personal_details_provider.dart';
import 'package:job_board/models/response/auth/user_response_model.dart';
import 'package:job_board/views/custom/custom_helper/app_style.dart';
import 'package:job_board/views/custom/custom_helper/height_spacer.dart';
import 'package:job_board/views/custom/custom_text/reusable_text.dart';

class ProfileSkills extends ConsumerWidget {
  final User? user; // Accept user

  const ProfileSkills({super.key, this.user});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    final skills = ref.watch(personalDetailsProvider).skills;

    final displaySkills =
        (skills.isNotEmpty ? skills : ['Flutter', 'Dart', 'Firebase'])
            .map((s) => s.split(','))
            .expand((e) => e)
            .map((s) => s.trim())
            .toList();

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ReusableText(
                text: 'Skills & Expertise',
                style: appstyle(
                  18.sp,
                  theme.colorScheme.onSurface,
                  FontWeight.w600,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.add_circle_outline,
                  color: theme.colorScheme.primary,
                  size: 24.sp,
                ),
              ),
            ],
          ),
          const HeightSpacer(size: 12),

          Wrap(
            spacing: 12.w,
            runSpacing: 12.h,
            children: displaySkills.map((skill) {
              return Chip(
                backgroundColor: theme.colorScheme.primary.withValues(
                  alpha: 0.06,
                ),
                side: BorderSide.none,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.r),
                ),
                label: ReusableText(
                  text: skill,
                  style: appstyle(
                    16.sp,
                    theme.colorScheme.primary,
                    FontWeight.w500,
                  ),
                ),
                deleteIcon: Icon(
                  Icons.close,
                  size: 16.sp,
                  color: theme.colorScheme.primary,
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
