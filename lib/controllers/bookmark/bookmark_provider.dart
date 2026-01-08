import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:job_board/models/request/bookmark/bookmark_request.dart';

import 'package:job_board/services/helpers/bookmark_helper.dart';

class BookmarkState {
  final bool isLoading;
  final List<BookmarkReq> bookmarks;
  final String? error;

  const BookmarkState({
    this.isLoading = false,
    this.bookmarks = const [],
    this.error,
  });

  BookmarkState copyWith({
    bool? isLoading,
    List<BookmarkReq>? bookmarks,
    String? error,
  }) {
    return BookmarkState(
      isLoading: isLoading ?? this.isLoading,
      bookmarks: bookmarks ?? this.bookmarks,
      error: error,
    );
  }
}

class BookmarkNotifier extends StateNotifier<BookmarkState> {
  BookmarkNotifier() : super(const BookmarkState());

  /// Fetch all bookmarks
  Future<void> fetchBookmarks() async {
    try {
      state = state.copyWith(isLoading: true, error: null);
      final List<BookmarkReq> bookmarks = await BookmarkHelper.getBookmarks();
      state = state.copyWith(bookmarks: bookmarks, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  /// Add a bookmark
  Future<void> addBookmark(String jobId) async {
    try {
      final bookmark = await BookmarkHelper.createBookmark(jobId);
      if (bookmark != null) {
        state = state.copyWith(bookmarks: [...state.bookmarks, bookmark]);
      } else {
        debugPrint('Bookmark already exists, skipping add.');
      }
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  /// Remove a bookmark
  Future<void> removeBookmark(String jobId) async {
    try {
      await BookmarkHelper.deleteBookmark(jobId);
      final updated = state.bookmarks.where((b) => b.job.id != jobId).toList();
      state = state.copyWith(bookmarks: updated);
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }
}

/// Riverpod provider
final bookmarkProvider = StateNotifierProvider<BookmarkNotifier, BookmarkState>(
  (ref) => BookmarkNotifier(),
);
