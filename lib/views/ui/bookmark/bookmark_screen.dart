import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:job_board/controllers/bookmark/bookmark_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:job_board/views/custom/custom_appbar/appbar.dart';
import 'package:job_board/views/custom/custom_helper/app_style.dart';
import 'package:job_board/views/custom/custom_helper/height_spacer.dart';
import 'package:job_board/views/custom/drawer/drawer_widget/drawer_widget.dart';
import 'package:job_board/views/ui/jobs/widgets/job_vertical_tile.dart';

class BookmarkScreen extends ConsumerStatefulWidget {
  const BookmarkScreen({super.key});

  @override
  ConsumerState<BookmarkScreen> createState() => _BookmarkScreenState();
}

class _BookmarkScreenState extends ConsumerState<BookmarkScreen> {
  @override
  void initState() {
    super.initState();
    // Fetch bookmarks when screen opens
    Future.microtask(
      () => ref.read(bookmarkProvider.notifier).fetchBookmarks(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bookmarkState = ref.watch(bookmarkProvider);
    final theme = Theme.of(context);

    if (bookmarkState.isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (bookmarkState.error != null) {
      return Scaffold(
        body: Center(child: Text('Error: ${bookmarkState.error}')),
      );
    }

    if (bookmarkState.bookmarks.isEmpty) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const HeightSpacer(size: 10),
              Text(
                'No Bookmark Added Yet',
                style: TextStyle(
                  color: theme.colorScheme.onSurface,
                  fontSize: 24.sp,
                ),
              ),
              Text(
                'Slide Left',
                style: appstyle(
                  20,
                  theme.colorScheme.onSurface,
                  FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.h),
        child: const CustomAppBar(child: DrawerWidget()),
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(12.h),
        itemCount: bookmarkState.bookmarks.length,
        itemBuilder: (context, index) {
          final bookmark = bookmarkState.bookmarks[index];
          final job = bookmark.job;
          return JobVerticalTile(
            job: job,
            onTap: () {
              context.push('/jobs', extra: {'id': job.id, 'title': job.title});
            },
          );
        },
      ),
    );

    //   return ListView.builder(
    //     padding: const EdgeInsets.all(16),
    //     itemCount: bookmarkState.bookmarks.length,
    //     itemBuilder: (context, index) {
    //       final bookmark = bookmarkState.bookmarks[index];
    //       final job = bookmark.job;

    //       return Card(
    //         margin: const EdgeInsets.symmetric(vertical: 8),
    //         child: ListTile(
    //           leading: CircleAvatar(
    //             backgroundImage: job.imageUrl.isNotEmpty
    //                 ? NetworkImage(job.imageUrl)
    //                 : const AssetImage('assets/images/user.png') as ImageProvider,
    //           ),
    //           title: Text(job.title),
    //           subtitle: Text('${job.company} • ${job.location}'),
    //           trailing: IconButton(
    //             icon: const Icon(Icons.delete, color: Colors.red),
    //             onPressed: () async {
    //               // Remove bookmark
    //               await ref
    //                   .read(bookmarkProvider.notifier)
    //                   .removeBookmark(job.id);
    //             },
    //           ),
    //           onTap: () {
    //             // Navigate to job detail page
    //             context.push('/jobs', extra: {'id': job.id, 'title': job.title});
    //           },
    //         ),
    //       );
    //     },
    //   );
  }
}
