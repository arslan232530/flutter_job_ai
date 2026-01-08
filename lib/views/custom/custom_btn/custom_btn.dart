import 'package:flutter/material.dart';
import 'package:job_board/constants/app_constant.dart';
import 'package:job_board/views/custom/custom_helper/app_style.dart';
import 'package:job_board/views/custom/custom_text/reusable_text.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, required this.text, this.color, this.onTap});

  final String text;
  final Color? color;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: theme.colorScheme.primary,
        width: width,
        height: height * 0.065,
        child: Center(
          child: ReusableText(
            text: text,
            style: appstyle(
              16,
              color ?? theme.colorScheme.onPrimary,
              FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
