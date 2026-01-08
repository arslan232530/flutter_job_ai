import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:job_board/views/custom/custom_helper/app_style.dart';
import 'package:job_board/views/custom/custom_helper/width_spacer.dart';

class SkillChip extends StatelessWidget {
  final String skill;

  const SkillChip({super.key, required this.skill});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: theme.colorScheme.primary.withAlpha(40),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: theme.colorScheme.primary.withAlpha(50)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            skill,
            style: appstyle(16, theme.colorScheme.primary, FontWeight.w500),
          ),
          const WidthSpacer(width: 8),
        ],
      ),
    );
  }
}
