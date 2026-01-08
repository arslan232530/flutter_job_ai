import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:job_board/views/custom/custom_helper/app_style.dart';
import 'package:job_board/views/custom/custom_helper/width_spacer.dart';
import 'package:job_board/views/custom/custom_text/reusable_text.dart';

class HomeSearchCard extends StatelessWidget {
  const HomeSearchCard({super.key, required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(14.r),
          boxShadow: [
            BoxShadow(
              color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.08),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(Icons.search, color: theme.colorScheme.primary, size: 22.sp),
            const WidthSpacer(width: 12),
            Expanded(
              child: ReusableText(
                text: 'Search jobs, companies, skills',
                style: appstyle(
                  16,
                  theme.colorScheme.onSurface.withValues(alpha: 0.6),
                  FontWeight.normal,
                ),
              ),
            ),
            Icon(
              Icons.tune,
              color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
              size: 20.sp,
            ),
          ],
        ),
      ),
    );
  }
}
