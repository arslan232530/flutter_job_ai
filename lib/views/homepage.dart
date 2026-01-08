import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:job_board/constants/app_constant.dart';
import 'package:job_board/controllers/jobs/job_provider.dart';
import 'package:job_board/controllers/profile/profile_provider.dart';
import 'package:job_board/views/custom/custom_appbar/appbar.dart';
import 'package:job_board/views/custom/custom_helper/app_style.dart';
import 'package:job_board/views/custom/custom_helper/heading_widget.dart';
import 'package:job_board/views/custom/custom_helper/height_spacer.dart';
import 'package:job_board/views/custom/custom_search/search_widget.dart';
import 'package:job_board/views/custom/drawer/drawer_widget/drawer_widget.dart';
import 'package:job_board/views/ui/jobs/widgets/job_vertical_tile.dart';
import 'package:job_board/views/ui/jobs/widgets/jobs_horizontal_tile.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    super.initState();

    // Fetch profile
    Future.microtask(() => ref.read(profileProvider.notifier).fetchProfile());

    // Fetch jobs
    Future.microtask(() => ref.read(jobProvider.notifier).fetchJobs());
  }

  @override
  Widget build(BuildContext context) {
    final profileState = ref.watch(profileProvider);
    final jobState = ref.watch(jobProvider);

    if (profileState.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (profileState.error != null) {
      return Center(child: Text(profileState.error!));
    }

    final user = profileState.profile?.user;
    final profileImage = user?.profile.url;
    final theme = Theme.of(context);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.h),
        child: CustomAppBar(
          actions: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(45.r),
                child: profileImage != null && profileImage.isNotEmpty
                    ? Image.network(profileImage, fit: BoxFit.cover)
                    : Image.asset('assets/images/user.png', fit: BoxFit.cover),
              ),
            ),
          ],
          child: const DrawerWidget(),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const HeightSpacer(size: 10),
                Text(
                  'Search \n Find & Apply',
                  style: appstyle(
                    38,
                    theme.colorScheme.onSurfaceVariant,
                    FontWeight.w600,
                  ),
                ),
                const HeightSpacer(size: 28),
                HomeSearchCard(
                  onTap: () {
                    context.push('/search');
                  },
                ),
                const HeightSpacer(size: 30),
                HeadingWidget(text: 'Popular Jobs', onTap: () {}),
                const HeightSpacer(size: 15),
                SizedBox(
                  height: height * 0.28,
                  child: jobState.isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : jobState.error != null
                      ? Center(child: Text(jobState.error!))
                      : ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: jobState.jobs.length,
                          itemBuilder: (context, index) {
                            final job = jobState.jobs[index];
                            return JobHorizontalTile(
                              job: job,
                              onTap: () {
                                context.push(
                                  '/jobs',
                                  extra: {'id': job.id, 'title': job.title},
                                );
                              },
                            );
                          },
                        ),
                ),

                const HeightSpacer(size: 20),
                HeadingWidget(text: 'Recently Posted', onTap: () {}),
                const HeightSpacer(size: 20),
                jobState.isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : jobState.error != null
                    ? Center(child: Text(jobState.error!))
                    : jobState.jobs.isEmpty
                    ? const Text('No jobs found')
                    : JobVerticalTile(
                        job: jobState.jobs.first,
                        onTap: () {
                          context.push(
                            '/jobs',
                            extra: {
                              'id': jobState.jobs.first.id,
                              'title': jobState.jobs.first.title,
                            },
                          );
                        },
                      ),

                const HeightSpacer(size: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
