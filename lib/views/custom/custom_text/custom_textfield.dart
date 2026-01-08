import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:job_board/views/custom/custom_helper/app_style.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.keyboardType,
    this.validator,
    this.suffixIcon,
    this.obscureText,
  });

  final TextEditingController controller;
  final String hintText;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final Widget? suffixIcon;
  final bool? obscureText;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        obscureText: obscureText ?? false,
        cursorColor: theme.colorScheme.primary,
        cursorHeight: 24.h,
        style: appstyle(16, theme.colorScheme.onSurface, FontWeight.w500),
        validator: validator,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
            horizontal: 20.w,
            vertical: 20.h,
          ),
          hintText: hintText,
          hintStyle: appstyle(
            16,
            theme.colorScheme.onSurface.withValues(alpha: 0.6),
            FontWeight.w500,
          ),
          suffixIcon: suffixIcon,
          filled: true,
          fillColor: theme.colorScheme.surface,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: BorderSide(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.2),
              width: 1,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: BorderSide(
              color: theme.colorScheme.primary,
              width: 1.5,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: BorderSide(color: theme.colorScheme.error, width: 1.2),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: BorderSide(color: theme.colorScheme.error, width: 1.5),
          ),
        ),
      ),
    );
  }
}
