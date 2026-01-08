import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:job_board/controllers/auth/personal/personal_details_provider.dart';
import 'package:job_board/controllers/profile/profile_state.dart';
import 'package:job_board/services/helpers/auth_helper.dart';

class ProfileNotifier extends StateNotifier<ProfileState> {
  final Ref ref;
  ProfileNotifier(this.ref) : super(const ProfileState());

  Future<void> fetchProfile() async {
    state = state.copyWith(isLoading: true, error: null);

    final result = await AuthHelper.fetchProfile();

    if (result.isSuccess && result.data != null) {
      final user = result.data!.user;

      ref.read(personalDetailsProvider.notifier).hydrateFromProfile(user);

      state = state.copyWith(profile: result.data, isLoading: false);
    } else {
      state = state.copyWith(
        isLoading: false,
        error: result.message ?? 'Failed to load profile',
      );
    }
  }
}
