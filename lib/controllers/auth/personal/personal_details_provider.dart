import 'package:flutter_riverpod/legacy.dart';
import 'package:job_board/controllers/auth/personal/personal_detail_state.dart';
import 'package:job_board/controllers/auth/personal/personal_details_notifier.dart';

final personalDetailsProvider =
    StateNotifierProvider<PersonalDetailsNotifier, PersonalDetailsState>(
      (ref) => PersonalDetailsNotifier(),
    );
