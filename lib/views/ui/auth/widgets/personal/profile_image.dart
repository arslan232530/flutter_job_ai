import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:job_board/controllers/image/profile_image_provider.dart';
import 'package:job_board/views/custom/custom_helper/app_style.dart';
import 'package:job_board/views/custom/custom_helper/height_spacer.dart';


class ProfilePictureSection extends ConsumerWidget {
  const ProfilePictureSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final imageState = ref.watch(profileImageProvider);

    final theme = Theme.of(context);
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: 120.w,
              height: 120.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: theme.colorScheme.primary,
                  width: 2.w,
                ),
              ),
              child: CircleAvatar(
                radius: 58.r,
                backgroundColor: theme.colorScheme.onSurface.withValues(
                  alpha: 0.2,
                ),
                backgroundImage: imageState.localPath != null
                    ? FileImage(File(imageState.localPath!))
                    : null,
                child: imageState.localPath == null
                    ? Icon(
                        Icons.person,
                        size: 80.sp,
                        color: theme.colorScheme.onSecondary,
                      )
                    : null,
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.all(8.sp),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: theme.colorScheme.surface,
                    width: 2.w,
                  ),
                ),
                child: Icon(
                  Icons.camera_alt,
                  size: 20.sp,
                  color: theme.colorScheme.onPrimary,
                ),
              ),
            ),
          ],
        ),
        const HeightSpacer(size: 16),
        InkWell(
          onTap: () {
            // We will connect the picker later
            ref.read(profileImageProvider.notifier).pickImage();
          },
          child: Text(
            'Change Photo',
            style: appstyle(18, theme.colorScheme.primary, FontWeight.w500),
          ),
        ),
      ],
    );
  }
}
