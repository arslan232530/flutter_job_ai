import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:job_board/constants/app_constant.dart';
import 'package:job_board/models/response/auth/user_response_model.dart';
import 'package:job_board/views/custom/custom_helper/app_style.dart';
import 'package:job_board/views/custom/custom_helper/height_spacer.dart';
import 'package:job_board/views/custom/custom_helper/width_spacer.dart';
import 'package:job_board/views/custom/custom_text/reusable_text.dart';

class ProfileHeader extends StatelessWidget {
  final User? user; // Accept user from parent

  const ProfileHeader({super.key, this.user});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Fallback dummy data
    final displayName = user?.username ?? 'Alex Johnson';
    final jobTitle = user?.jobTitle ?? 'Senior Flutter Developer';
    final location = user?.location ?? 'San Francisco, CA';
    final profileImage = user?.profile.url;

    return InkWell(
      onTap: () => context.go('/personal-details'),
      child: Container(
        width: width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              theme.colorScheme.primary.withValues(alpha: 0.1),
              theme.colorScheme.primary.withValues(alpha: 0.05),
            ],
            begin: Alignment.topRight,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 40.h),
          child: Row(
            children: [
              Stack(
                children: [
                  Container(
                    width: 90.w,
                    height: 90.h,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: theme.colorScheme.primary,
                        width: 3.w,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: theme.colorScheme.primary.withValues(alpha: 0.2),
                          blurRadius: 10,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(45.r),
                      child: profileImage != null && profileImage.isNotEmpty
                          ? Image.network(profileImage, fit: BoxFit.cover)
                          : Image.asset('assets/images/user.png', fit: BoxFit.cover),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 32.w,
                      height: 32.h,
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primary,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: theme.colorScheme.surface,
                          width: 2.w,
                        ),
                      ),
                      child: Icon(
                        Icons.edit,
                        color: theme.colorScheme.onPrimary,
                        size: 16.sp,
                      ),
                    ),
                  ),
                ],
              ),
              const WidthSpacer(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ReusableText(
                      text: displayName,
                      style: appstyle(
                        24.sp,
                        theme.colorScheme.onSurface,
                        FontWeight.w700,
                      ),
                    ),
                    const HeightSpacer(size: 4),
                    Row(
                      children: [
                        Icon(
                          Icons.work_outline,
                          size: 16.sp,
                          color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                        ),
                        const WidthSpacer(width: 6),
                        ReusableText(
                          text: jobTitle,
                          style: appstyle(
                            14.sp,
                            theme.colorScheme.onSurface.withValues(alpha: 0.7),
                            FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    const HeightSpacer(size: 8),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                          size: 16.sp,
                          color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                        ),
                        const WidthSpacer(width: 6),
                        ReusableText(
                          text: location,
                          style: appstyle(
                            14.sp,
                            theme.colorScheme.onSurface.withValues(alpha: 0.7),
                            FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
