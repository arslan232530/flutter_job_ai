import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:job_board/controllers/jobs/search_provider.dart';
import 'package:job_board/views/custom/custom_search/search_loading.dart';
import 'package:job_board/views/ui/jobs/widgets/job_vertical_tile.dart';
import 'package:job_board/views/ui/search/widget/search_field.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  TextEditingController search = TextEditingController();

  void _performSearch() {
    final query = search.text.trim();
    ref.read(searchProvider.notifier).searchJobs(query: query);
  }

  @override
  Widget build(BuildContext context) {
    final searchState = ref.watch(searchProvider);
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.colorScheme.primary,
        iconTheme: IconThemeData(color: theme.colorScheme.onPrimary),
        title: SearchField(
          hintText: 'Search for a job',
          controller: search,
          onEditingComplete: _performSearch,
          suffixIcon: GestureDetector(
            onTap: _performSearch,
            child: const Icon(Icons.search),
          ),
        ),
        elevation: 0,
      ),
      body: _buildBody(searchState),
    );
  }

  Widget _buildBody(SearchState searchState) {
    if (searchState.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (searchState.error != null) {
      return Center(child: Text('Error: ${searchState.error}'));
    }

    if (searchState.jobs.isEmpty) {
      return const SearchLoading(text: 'Start Searching For Jobs');
    }

    // Display the list of jobs
    return ListView.builder(
      padding: EdgeInsets.all(12.h),
      itemCount: searchState.jobs.length,
      itemBuilder: (context, index) {
        final job = searchState.jobs[index];
        return JobVerticalTile(
          job: job,
          onTap: () {
            context.push('/jobs', extra: {'id': job.id, 'title': job.title});
          },
        );
      },
    );
  }
}
