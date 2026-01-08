import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:job_board/controllers/profile/profile_provider.dart';
import 'package:job_board/views/custom/custom_appbar/appbar.dart';
import 'package:job_board/views/custom/custom_helper/height_spacer.dart';
import 'package:job_board/views/custom/drawer/drawer_widget/drawer_widget.dart';
import 'package:job_board/views/ui/profile/profile_widget/profile_header.dart';
import 'package:job_board/views/ui/profile/profile_widget/profile_personal_information.dart';
import 'package:job_board/views/ui/profile/profile_widget/profile_resume.dart';
import 'package:job_board/views/ui/profile/profile_widget/profile_skills.dart';

class ProfilePage extends ConsumerStatefulWidget {
  const ProfilePage({super.key});

  @override
  ConsumerState<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  @override
  void initState() {
    super.initState();
    // Fetch profile when the page loads
    Future.microtask(() => ref.read(profileProvider.notifier).fetchProfile());
  }

  @override
  Widget build(BuildContext context) {
    final profileState = ref.watch(profileProvider);

    if (profileState.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (profileState.error != null) {
      return Center(child: Text(profileState.error!));
    }

    final user = profileState.profile?.user;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.h),
        child: CustomAppBar(
          text: 'Profile',
          child: Padding(
            padding: EdgeInsets.all(12.0.h),
            child: const DrawerWidget(),
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProfileHeader(user: user),
            const HeightSpacer(size: 24),
            ProfilePersonalInformation(user: user),
            const HeightSpacer(size: 24),
            ProfileResume(user: user),
            const HeightSpacer(size: 24),
            ProfileSkills(user: user),
          ],
        ),
      ),
    );
  }
}
