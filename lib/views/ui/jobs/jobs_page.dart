import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:job_board/constants/app_constant.dart';
import 'package:job_board/controllers/ai/ai_analysis_provider.dart';
import 'package:job_board/controllers/ai/ai_payment_provider.dart';
import 'package:job_board/controllers/bookmark/bookmark_provider.dart';
import 'package:job_board/controllers/jobs/applybtn/apply_provider.dart';
import 'package:job_board/controllers/jobs/singlejob/single_job_provider.dart';
import 'package:job_board/controllers/profile/profile_provider.dart';
import 'package:job_board/helper/ui_helper.dart';
import 'package:job_board/views/custom/custom_appbar/appbar.dart';
import 'package:job_board/views/custom/custom_btn/custom_outline_btn.dart';
import 'package:job_board/views/custom/custom_helper/app_style.dart';
import 'package:job_board/views/custom/custom_helper/height_spacer.dart';
import 'package:job_board/views/custom/custom_text/reusable_text.dart';
import 'package:job_board/views/ui/jobs/widgets/ai/ai_analysis_bottom_sheet.dart';
import 'package:job_board/views/ui/jobs/widgets/jobs_chip.dart';
import 'package:shared_preferences/shared_preferences.dart';

class JobPage extends ConsumerStatefulWidget {
  const JobPage({super.key, required this.title, required this.id});

  final String title;
  final String id;

  @override
  ConsumerState<JobPage> createState() => _JobPageState();
}

class _JobPageState extends ConsumerState<JobPage> {
  @override
  void initState() {
    super.initState();
    // Fetch job when page loads
    Future.microtask(() {
      ref.read(singleJobProvider.notifier).fetchJob(widget.id);
      ref.read(bookmarkProvider.notifier).fetchBookmarks(); // add this
    });
  }

  @override
  Widget build(BuildContext context) {
    final bookmarkState = ref.watch(bookmarkProvider);
    final bookmarkNotifier = ref.read(bookmarkProvider.notifier);
    final theme = Theme.of(context);
    final jobState = ref.watch(singleJobProvider);

    // Check if this job is already bookmarked
    final isBookmarked = bookmarkState.bookmarks.any(
      (b) => b.job.id == widget.id,
    );

    // Loading state
    if (jobState.isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    // Error state
    if (jobState.error != null) {
      return Scaffold(body: Center(child: Text('Error: ${jobState.error}')));
    }

    final job = jobState.job;

    // Null state
    if (job == null) {
      return const Scaffold(body: Center(child: Text('Job not found')));
    }

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.h),
        child: CustomAppBar(
          text: widget.title,
          actions: [
            IconButton(
              icon: Icon(
                isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                color: theme.colorScheme.onSurface,
              ),
              onPressed: () async {
                try {
                  if (isBookmarked) {
                    await bookmarkNotifier.removeBookmark(widget.id);
                    UIHelper.showErrorSnackBar(context, 'Bookmarked Removed');
                  } else {
                    await bookmarkNotifier.addBookmark(widget.id);
                    // Optional: show a Snackbar

                    UIHelper.showSuccessSnackBar(context, 'Bookmark Added');
                  }
                } catch (e) {
                  UIHelper.showErrorSnackBar(context, 'Error $e');
                }
              },
            ),
          ],
          child: GestureDetector(
            onTap: () => context.pop(),
            child: Icon(Icons.arrow_back, color: theme.colorScheme.onSurface),
          ),
        ),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            ListView(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              children: [
                /// Company Card
                Container(
                  padding: EdgeInsets.all(16.w),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        theme.colorScheme.primary.withAlpha(20),
                        theme.colorScheme.onPrimary.withAlpha(10),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(24.r),
                    boxShadow: [
                      BoxShadow(
                        color: theme.colorScheme.surface.withAlpha(20),
                        blurRadius: 12,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            padding: EdgeInsets.all(2.w),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: theme.colorScheme.primary,
                                width: 2,
                              ),
                              shape: BoxShape.circle,
                            ),
                            child: ClipRRect(
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
                                      color: theme.colorScheme.primary
                                          .withValues(alpha: 0.15),
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
                          ),
                          SizedBox(width: 14.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ReusableText(
                                  text: job.company,
                                  style: appstyle(
                                    18,
                                    theme.colorScheme.onSurface,
                                    FontWeight.w700,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    ReusableText(
                                      text: job.location,
                                      style: appstyle(
                                        14,
                                        theme.colorScheme.onSurface.withAlpha(
                                          150,
                                        ),
                                        FontWeight.w400,
                                      ),
                                    ),
                                    ReusableText(
                                      text:
                                          'Posted: ${job.updatedAt.toLocal().toString().split(' ')[0]}', // Example posted date
                                      style: appstyle(
                                        12,
                                        theme.colorScheme.onSurface.withAlpha(
                                          120,
                                        ),
                                        FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                                const HeightSpacer(size: 10),
                                Wrap(
                                  spacing: 6.w,
                                  runSpacing: 4.h,
                                  children: [JobChip(label: job.salary)],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const HeightSpacer(size: 16),
                      ReusableText(
                        text: job.title,
                        style: appstyle(
                          22,
                          theme.colorScheme.onSurface,
                          FontWeight.w700,
                        ),
                      ),
                      const HeightSpacer(size: 10),
                      Wrap(
                        spacing: 6.w,
                        runSpacing: 4.h,
                        children: const [
                          JobChip(label: 'Remote'),
                          JobChip(label: 'Full-time'),
                          JobChip(label: 'Senior'),
                        ],
                      ),
                    ],
                  ),
                ),

                const HeightSpacer(size: 24),

                /// Description Section
                ReusableText(
                  text: 'Description',
                  style: appstyle(
                    20,
                    theme.colorScheme.primary,
                    FontWeight.w600,
                  ),
                ),
                const HeightSpacer(size: 10),
                Text(
                  job.description,
                  style: appstyle(
                    16,
                    theme.colorScheme.onSurface,
                    FontWeight.normal,
                  ),
                  textAlign: TextAlign.justify,
                ),

                const HeightSpacer(size: 20),

                /// Requirements Section
                ReusableText(
                  text: 'Requirements',
                  style: appstyle(
                    20,
                    theme.colorScheme.primary,
                    FontWeight.w600,
                  ),
                ),
                const HeightSpacer(size: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: job.requirements.map((req) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '• ',
                            style: appstyle(
                              16,
                              theme.colorScheme.onSurface,
                              FontWeight.w500,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              req,
                              style: appstyle(
                                16,
                                theme.colorScheme.onSurface,
                                FontWeight.normal,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
                const HeightSpacer(size: 80), // Bottom spacing for button
              ],
            ),

            /// Apply Button
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 80.h),
                child: Consumer(
                  builder: (context, ref, child) {
                    final applyState = ref.watch(applyJobProvider);
                    final applyNotifier = ref.read(applyJobProvider.notifier);

                    return CustomOutlineBtn(
                      onTap: () async {
                        await applyNotifier.applyAndSendMessage(
                          agentId: job.agentId,
                          jobTitle: job.title,
                        );

                        if (applyState.success) {
                          context.go('/drawermain'); // Navigate after success
                        } else if (applyState.error != null) {
                          UIHelper.showErrorSnackBar(
                            context,
                            applyState.error!,
                          );
                        }
                      },
                      width: double.infinity,
                      hieght: height * 0.06,
                      text: applyState.isLoading ? 'Applying...' : 'Apply Now',
                      color: theme.colorScheme.onPrimary,
                      color2: theme.colorScheme.primary,
                    );
                  },
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                child: Consumer(
                  builder: (context, ref, child) {
                    final aiState = ref.watch(aiAnalysisProvider);
                    final profileState = ref.watch(profileProvider);
                    final isPaid = profileState.profile?.user.aiPaid ?? false;
                    final paymentState = ref.watch(aiPaymentProvider);
                    final isPaymentLoading = paymentState.isLoading;
                    final isAnalyzing = aiState.isLoading;
                    return CustomOutlineBtn(
                      width: double.infinity,
                      hieght: height * 0.06,
                      text: isPaymentLoading
                          ? 'Processing...'
                          : isAnalyzing
                          ? 'Analyzing...'
                          : (isPaid
                                ? 'Analyze With AI'
                                : 'Pay for AI Analysis'),
                      color: theme.colorScheme.surface,
                      color2: theme.colorScheme.onSurface,
                      onTap: isPaymentLoading
                          ? null
                          : () async {
                              final pref =
                                  await SharedPreferences.getInstance();
                              final token = pref.getString('ljobtoken');
                              if (isPaid) {
                                await ref
                                    .read(aiAnalysisProvider.notifier)
                                    .analyzeWithBackend(
                                      userSkills:
                                          pref.getStringList('userskills') ??
                                          [],
                                      jobRequirements: job.requirements,
                                    );

                                final aiState = ref.read(aiAnalysisProvider);
                                if (aiState.analysis == null) return;

                                showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(24),
                                    ),
                                  ),
                                  builder: (_) => AiAnalysisBottomSheet(
                                    analysis: aiState.analysis!,
                                  ),
                                );
                              } else {
                                await ref
                                    .read(aiPaymentProvider.notifier)
                                    .payForAi(token!);
                              }
                            },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
