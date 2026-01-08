import 'package:flutter/material.dart';
import 'package:job_board/views/custom/custom_helper/app_style.dart';
import 'package:job_board/views/custom/custom_text/reusable_text.dart';

class HeadingWidget extends StatelessWidget {
  const HeadingWidget({super.key, required this.text, this.onTap});

  final String text;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ReusableText(
          text: text,
          style: appstyle(20, theme.colorScheme.onSurface, FontWeight.w600),
        ),

        if (onTap != null)
          InkWell(
            borderRadius: BorderRadius.circular(8),
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
              child: ReusableText(
                text: 'View all',
                style: appstyle(16, theme.colorScheme.primary, FontWeight.w500),
              ),
            ),
          ),
      ],
    );
  }
}
