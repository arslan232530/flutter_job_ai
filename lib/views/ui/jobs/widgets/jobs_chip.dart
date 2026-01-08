import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:job_board/helper/color_gen.dart';
import 'package:job_board/views/custom/custom_helper/app_style.dart';
import 'package:job_board/views/custom/custom_text/reusable_text.dart';


class JobChip extends StatelessWidget {
  const JobChip({super.key, required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final colors = pastelColorPairFromLabel(label);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: colors.background,
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: ReusableText(
        text: label,
        style: appstyle(14, colors.text, FontWeight.w500),
      ),
    );
  }
}
