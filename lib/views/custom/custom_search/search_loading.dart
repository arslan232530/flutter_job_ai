import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:job_board/views/custom/custom_helper/app_style.dart';
import 'package:job_board/views/custom/custom_text/reusable_text.dart';

class SearchLoading extends StatelessWidget {
  const SearchLoading({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.all(20.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/images/optimized_search.png'),
          ReusableText(
            text: text,
            style: appstyle(24, theme.colorScheme.onSurface, FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
