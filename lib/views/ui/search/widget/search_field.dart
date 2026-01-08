import 'package:flutter/material.dart';
import 'package:job_board/views/custom/custom_helper/app_style.dart';

class SearchField extends StatelessWidget {
  const SearchField({
    super.key,
    required this.hintText,
    required this.controller,
    this.validator,
    this.keyboard,
    this.suffixIcon,
    this.obscureText,
    this.onEditingComplete,
  });

  final TextEditingController controller;
  final String hintText;
  final TextInputType? keyboard;
  final String? Function(String?)? validator;
  final Widget? suffixIcon;
  final void Function()? onEditingComplete;
  final bool? obscureText;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      color: theme.colorScheme.primary,
      child: TextField(
        keyboardType: keyboard,
        obscureText: obscureText ?? false,
        onEditingComplete: onEditingComplete,
        decoration: InputDecoration(
          hintText: hintText.toUpperCase(),
          suffixIcon: suffixIcon,
          suffixIconColor: theme.colorScheme.onPrimary,
          hintStyle: appstyle(16, theme.colorScheme.onPrimary, FontWeight.w500),
          // contentPadding: EdgeInsets.only(left: 24),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.zero,
            borderSide: BorderSide(
              color: theme.colorScheme.onPrimary,
              width: 0.5,
            ),
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.zero,
            borderSide: BorderSide(color: Colors.transparent, width: 0),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.zero,
            borderSide: BorderSide(color: theme.colorScheme.error, width: 0.5),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.zero,
            borderSide: BorderSide(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
              width: 0,
            ),
          ),
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.zero,
            borderSide: BorderSide(color: Colors.transparent, width: 0),
          ),
          border: InputBorder.none,
        ),
        controller: controller,
        cursorHeight: 25,
        style: appstyle(14, theme.colorScheme.onPrimary, FontWeight.w500),
        onSubmitted: validator,
        cursorColor: theme.colorScheme.onPrimary,
      ),
    );
  }
}
