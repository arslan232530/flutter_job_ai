import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddSkillButton extends StatelessWidget {
  final VoidCallback onPressed;

  const AddSkillButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 48.w,
        height: 48.h,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: theme.colorScheme.onSurface.withAlpha(100), width: 1.5),
        ),
        child:  Icon(Icons.add, size: 24.sp, color: theme.colorScheme.onSurface.withAlpha(150)),
      ),
    );
  }
}
