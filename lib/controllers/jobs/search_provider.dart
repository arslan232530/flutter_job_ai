import 'package:flutter_riverpod/legacy.dart';
import 'package:job_board/models/response/jobs/jobs_response.dart';
import 'package:job_board/services/helpers/job_helper.dart';

class SearchState {
  final bool isLoading;
  final List<JobsResponse> jobs;
  final String? error;

  const SearchState({this.isLoading = false, this.jobs = const [], this.error});

  SearchState copyWith({
    bool? isLoading,
    List<JobsResponse>? jobs,
    String? error,
  }) {
    return SearchState(
      isLoading: isLoading ?? this.isLoading,
      jobs: jobs ?? this.jobs,
      error: error,
    );
  }
}

class SearchNotifier extends StateNotifier<SearchState> {
  SearchNotifier() : super(const SearchState());

  Future<void> searchJobs({
    String? query,
    String? location,
    String? company,
  }) async {
    try {
      state = state.copyWith(isLoading: true, error: null);

      final List<JobsResponse> jobs = await JobHelper.getJobs(
        search: query,
        location: location,
        company: company,
      );

      state = state.copyWith(jobs: jobs, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }
}

final searchProvider = StateNotifierProvider<SearchNotifier, SearchState>(
  (ref) => SearchNotifier(),
);
