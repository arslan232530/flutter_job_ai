import 'package:flutter_riverpod/legacy.dart';
import 'package:job_board/controllers/image/profile_image_notifier.dart';
import 'package:job_board/controllers/image/profile_image_state.dart';

final profileImageProvider =
    StateNotifierProvider<ProfileImageNotifier, ProfileImageState>(
      (ref) => ProfileImageNotifier(),
    );
