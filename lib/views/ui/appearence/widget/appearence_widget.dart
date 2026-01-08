import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:job_board/views/custom/custom_helper/app_style.dart';
import 'package:job_board/views/custom/custom_text/reusable_text.dart';

Widget themeTile(
  BuildContext context, {
  required IconData icon,
  required String title,
  required bool isActive,
  required VoidCallback onTap,
}) {
  final theme = Theme.of(context);

  return Container(
    margin: EdgeInsets.only(bottom: 12.h),
    decoration: BoxDecoration(
      color: isActive
          ? theme.colorScheme.primary.withValues(alpha: 0.12)
          : theme.colorScheme.surface,
      borderRadius: BorderRadius.circular(12.r),
      border: Border.all(
        color: isActive
            ? theme.colorScheme.primary
            : theme.dividerColor.withValues(alpha: 0.2),
      ),
      boxShadow: [
        BoxShadow(
          color: theme.shadowColor.withValues(alpha: 0.04),
          blurRadius: 6.r,
          offset: Offset(0, 2.h),
        ),
      ],
    ),
    child: ListTile(
      leading: Icon(
        icon,
        color: isActive
            ? theme.colorScheme.secondary
            : theme.colorScheme.onSurface.withValues(alpha: 0.7),
      ),
      title: ReusableText(
        text: title,
        style: appstyle(
          18,
          theme.colorScheme.onSurfaceVariant,
          isActive ? FontWeight.w600 : FontWeight.w400,
        ),
      ),
      trailing: isActive
          ? Icon(Icons.check_circle, color: theme.colorScheme.secondary)
          : const Icon(Icons.chevron_right),
      onTap: onTap,
    ),
  );
}
