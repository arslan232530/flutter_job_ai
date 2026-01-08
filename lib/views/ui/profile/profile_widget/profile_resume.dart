import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:job_board/constants/app_constant.dart';
import 'package:job_board/models/response/auth/user_response_model.dart';
import 'package:job_board/views/custom/custom_helper/app_style.dart';
import 'package:job_board/views/custom/custom_helper/height_spacer.dart';
import 'package:job_board/views/custom/custom_helper/width_spacer.dart';
import 'package:job_board/views/custom/custom_text/reusable_text.dart';

class ProfileResume extends StatelessWidget {
  final User? user; // Accept user

  const ProfileResume({super.key, this.user});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Dummy/fallback data
    final resumeName = user?.profile.url != null && user!.profile.url.isNotEmpty
        ? user!.profile.url.split('/').last
        : 'Alex_Johnson_Resume.pdf';
    final updatedAt = user?.updatedAt != null
        ? '${DateTime.now().difference(user!.updatedAt).inDays} days ago'
        : '2 days ago';
    final fileSize = '2.4 MB'; // Assuming you don't have size info

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ReusableText(
            text: 'Resume',
            style: appstyle(
              18.sp,
              theme.colorScheme.onSurface,
              FontWeight.w600,
            ),
          ),
          const HeightSpacer(size: 12),
          Container(
            width: width,
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(
                color: theme.colorScheme.primary.withValues(alpha: 0.6),
              ),
              boxShadow: [
                BoxShadow(
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Padding(
              padding: EdgeInsets.all(16.h),
              child: Row(
                children: [
                  Container(
                    width: 50.w,
                    height: 50.h,
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Icon(
                      Icons.description_outlined,
                      color: theme.colorScheme.primary,
                      size: 28.sp,
                    ),
                  ),
                  const WidthSpacer(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ReusableText(
                          text: resumeName,
                          style: appstyle(
                            16.sp,
                            theme.colorScheme.onSurface,
                            FontWeight.w600,
                          ),
                        ),
                        const HeightSpacer(size: 4),
                        ReusableText(
                          text: 'Updated $updatedAt • $fileSize',
                          style: appstyle(
                            12.sp,
                            theme.colorScheme.onSurface.withValues(alpha: 0.6),
                            FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.download_outlined,
                      color: theme.colorScheme.primary,
                      size: 24.sp,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
