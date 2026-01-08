import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:job_board/models/response/jobs/jobs_response.dart';
import 'package:job_board/views/custom/custom_helper/app_style.dart';
import 'package:job_board/views/custom/custom_helper/height_spacer.dart';
import 'package:job_board/views/custom/custom_helper/width_spacer.dart';
import 'package:job_board/views/custom/custom_text/reusable_text.dart';
import 'package:job_board/views/ui/jobs/widgets/jobs_chip.dart';

class JobVerticalTile extends StatelessWidget {
  final JobsResponse job;
  final VoidCallback? onTap;

  const JobVerticalTile({super.key, required this.job, this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      borderRadius: BorderRadius.circular(16.r),
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 14.h),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: theme.shadowColor.withValues(alpha: 0.06),
              blurRadius: 12,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Top Row: Logo + Company + Salary
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Company Logo
                ClipRRect(
                  borderRadius: BorderRadius.circular(45.r),
                  child: Image.network(
                    job.imageUrl, // Use job's imageUrl
                    width: 40.w,
                    height: 40.w,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      // Fallback if image fails to load
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
                          job.company.isNotEmpty
                              ? job.company[0].toUpperCase()
                              : '?',
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

                /// Company + Location
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ReusableText(
                        text: job.company, 
                        style: appstyle(
                          16,
                          theme.colorScheme.onSurface,
                          FontWeight.w600,
                        ),
                      ),
                      // FIXED: Use actual job location
                      ReusableText(
                        text: job.location.isNotEmpty
                            ? job.location
                            : 'Remote', // Use job.location
                        style: appstyle(
                          13,
                          theme.colorScheme.onSurface.withValues(alpha: 0.6),
                          FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),

                /// Salary Badge
                // if (job.salary.isNotEmpty)
                //   Container(
                //     padding: EdgeInsets.symmetric(
                //       horizontal: 10.w,
                //       vertical: 6.h,
                //     ),
                //     decoration: BoxDecoration(
                //       color: theme.colorScheme.primary.withValues(alpha: 0.2),
                //       borderRadius: BorderRadius.circular(14.r),
                //     ),
                //     child: ReusableText(
                //       text: job.salary, // Use actual salary
                //       style: appstyle(
                //         14,
                //         theme.colorScheme.onSurface,
                //         FontWeight.w600,
                //       ),
                //     ),
                //   ),
              ],
            ),

            const HeightSpacer(size: 14),

            /// Job Title - FIXED: Use actual job.title
            ReusableText(
              text: job.title, // NOT 'Senior Flutter Developer'
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

            const HeightSpacer(size: 14),

            /// Bottom Action Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // FIXED: Use actual posted date if available
                if (job.updatedAt.toString().isNotEmpty)
                  ReusableText(
                    text: 'Posted ${job.updatedAt}',
                    style: appstyle(
                      12,
                      theme.colorScheme.onSurface.withValues(alpha: 0.5),
                      FontWeight.w400,
                    ),
                  )
                else if (job.createdAt.toString().isNotEmpty)
                  ReusableText(
                    text: 'Posted recently',
                    style: appstyle(
                      12,
                      theme.colorScheme.onSurface.withValues(alpha: 0.5),
                      FontWeight.w400,
                    ),
                  )
                else
                  ReusableText(
                    text: 'Posted recently',
                    style: appstyle(
                      12,
                      theme.colorScheme.onSurface.withValues(alpha: 0.5),
                      FontWeight.w400,
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
