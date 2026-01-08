import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:job_board/views/custom/custom_helper/app_style.dart';
import 'package:job_board/views/custom/custom_helper/height_spacer.dart';
import 'package:job_board/views/custom/custom_helper/width_spacer.dart';

class AiAnalysisBottomSheet extends StatelessWidget {
  final Map<String, dynamic> analysis;

  const AiAnalysisBottomSheet({super.key, required this.analysis});

  @override
  Widget build(BuildContext context) {
    final bool isEligible = analysis['isEligible'] ?? false;
    final int matchPercentage = analysis['matchPercentage'] ?? 0;
    final List matchedSkills = analysis['matchedSkills'] ?? [];
    final List missingSkills = analysis['missingSkills'] ?? [];
    final String summary = analysis['summary'] ?? '';

    final theme = Theme.of(context);

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.vertical(top: Radius.circular(25.r)),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Header
              Center(
                child: Container(
                  width: 50.w,
                  height: 5.h,
                  margin: EdgeInsets.only(bottom: 16.h),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.4),
                    borderRadius: BorderRadius.circular(5.r),
                  ),
                ),
              ),

              Text(
                isEligible ? 'Eligible for this job ✅' : 'Not eligible ❌',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: isEligible
                      ? theme.colorScheme.primary
                      : theme.colorScheme.error,
                ),
              ),

              SizedBox(height: 12.h),

              /// Match Percentage
              Row(
                children: [
                  Expanded(
                    child: LinearProgressIndicator(
                      value: matchPercentage / 100,
                      color: isEligible ? Colors.green : Colors.red,
                      backgroundColor: theme.colorScheme.onSurface.withValues(
                        alpha: 0.3,
                      ),
                      minHeight: 10.h,
                    ),
                  ),
                  const WidthSpacer(width: 8),
                  Text(
                    '$matchPercentage%',
                    style: appstyle(
                      14,
                      isEligible
                          ? theme.colorScheme.primary
                          : theme.colorScheme.error,
                      FontWeight.bold,
                    ),
                  ),
                ],
              ),

              SizedBox(height: 16.h),

              /// Matched Skills
              if (matchedSkills.isNotEmpty) ...[
                Text(
                  'Matched Skills',
                  style: appstyle(
                    16,
                    theme.colorScheme.primary,
                    FontWeight.bold,
                  ),
                ),
                const HeightSpacer(size: 8),
                Wrap(
                  spacing: 6.w,
                  runSpacing: 6.h,
                  children: matchedSkills
                      .map(
                        (skill) => Chip(
                          label: Text(skill),
                          backgroundColor: theme.colorScheme.primary,
                          labelStyle: TextStyle(
                            color: theme.colorScheme.onPrimary,
                          ),
                        ),
                      )
                      .toList(),
                ),
                const HeightSpacer(size: 16),
              ],

              /// Missing Skills
              if (missingSkills.isNotEmpty) ...[
                Text(
                  'Missing Skills',
                  style: appstyle(16, theme.colorScheme.error, FontWeight.bold),
                ),
                const HeightSpacer(size: 8),
                Wrap(
                  spacing: 6.w,
                  runSpacing: 6.h,

                  children: missingSkills
                      .map(
                        (skill) => Chip(
                          label: Text(skill),
                          backgroundColor: theme.colorScheme.error,
                          labelStyle: TextStyle(
                            color: theme.colorScheme.onError,
                          ),
                        ),
                      )
                      .toList(),
                ),
                const HeightSpacer(size: 16),
              ],

              /// Summary
              Text(
                'Summary',
                style: appstyle(
                  16,
                  theme.colorScheme.onSurface,
                  FontWeight.bold,
                ),
              ),
              const HeightSpacer(size: 8),
              Text(
                summary,
                style: appstyle(
                  16,
                  theme.colorScheme.onSurface,
                  FontWeight.w400,
                ),
              ),

              const HeightSpacer(size: 30),
            ],
          ),
        ),
      ),
    );
  }
}
