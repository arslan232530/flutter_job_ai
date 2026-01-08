import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:job_board/constants/app_constant.dart';
import 'package:job_board/models/response/jobs/jobs_response.dart';
import 'package:job_board/views/custom/custom_helper/app_style.dart';
import 'package:job_board/views/custom/custom_helper/height_spacer.dart';
import 'package:job_board/views/custom/custom_helper/width_spacer.dart';
import 'package:job_board/views/custom/custom_text/reusable_text.dart';
import 'package:job_board/views/ui/jobs/widgets/jobs_chip.dart';

class JobHorizontalTile extends StatelessWidget {
  final JobsResponse job;
  final VoidCallback? onTap;

  const JobHorizontalTile({super.key, required this.job, this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      borderRadius: BorderRadius.circular(20.r),
      onTap: onTap,
      child: Container(
        width: width * 0.74,
        margin: EdgeInsets.only(right: 14.w),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(20.r),
          boxShadow: [
            BoxShadow(
              color: theme.shadowColor.withValues(alpha: 0.05),
              blurRadius: 14.r,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Company Row
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(45.r),
                  child: Image.network(
                    job.imageUrl,
                    width: 50.w,
                    height: 50.w,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: 50.w,
                        height: 50.w,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: theme.colorScheme.primary.withValues(
                            alpha: 0.15,
                          ),
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          job.title.isNotEmpty ? job.title[0] : '?',
                          style: appstyle(
                            18,
                            theme.colorScheme.primary,
                            FontWeight.w600,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const WidthSpacer(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ReusableText(
                        text: job.company.isNotEmpty ? job.company : 'Facebook',
                        style: appstyle(
                          16,
                          theme.colorScheme.onSurface,
                          FontWeight.w600,
                        ),
                      ),
                      ReusableText(
                        text: job.location.isNotEmpty
                            ? job.location
                            : 'Washington, DC',
                        style: appstyle(
                          13,
                          theme.colorScheme.onSurface.withValues(alpha: 0.6),
                          FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const HeightSpacer(size: 18),

            /// Job Title
            ReusableText(
              text: job.title.isNotEmpty
                  ? job.title
                  : 'Senior Flutter Developer',
              style: appstyle(18, theme.colorScheme.onSurface, FontWeight.w600),
            ),

            const HeightSpacer(size: 10),

            /// Job Tags
            Wrap(
              spacing: 8.w,
              runSpacing: 6.h,
              children: const [
                JobChip(label: 'Remote'),
                JobChip(label: 'Full-time'),
                JobChip(label: 'Senior'),
              ],
            ),

            const Spacer(),

            /// Salary + Action
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 6.h,
                  ),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Row(
                    children: [
                      ReusableText(
                        text:
                            '${job.salary.isNotEmpty ? '${job.salary}' : '16k/monthly'}',
                        style: appstyle(
                          18,
                          theme.colorScheme.onSurface,
                          FontWeight.w600,
                        ),
                      ),
                      // ReusableText(
                      //   text: 'monthly',
                      //   style: appstyle(
                      //     14,
                      //     theme.colorScheme.onSurface.withValues(alpha: 0.6),
                      //     FontWeight.w600,
                      //   ),
                      // ),
                    ],
                  ),
                ),
                Icon(
                  Icons.arrow_forward_rounded,
                  color: theme.colorScheme.primary,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
