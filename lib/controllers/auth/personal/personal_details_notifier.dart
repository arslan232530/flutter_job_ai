import 'package:flutter_riverpod/legacy.dart';
import 'package:job_board/controllers/auth/personal/personal_detail_state.dart';
import 'package:job_board/models/response/auth/user_response_model.dart';

class PersonalDetailsNotifier extends StateNotifier<PersonalDetailsState> {
  PersonalDetailsNotifier() : super(PersonalDetailsState.initial());

  void hydrateFromProfile(User user) {
    state = state.copyWith(
      location: user.location,
      phone: user.phone,
      skills: user.skills,
      jobTitle: user.jobTitle,
      experience: user.experience,
    );
  }

  void updateLocation(String value) {
    state = state.copyWith(location: value);
  }

  void updatePhone(String value) {
    state = state.copyWith(phone: value);
  }

  void addSkill(String skill) {
    state = state.copyWith(skills: [...state.skills, skill]);
  }

  void removeSkill(String skill) {
    state = state.copyWith(
      skills: state.skills.where((s) => s != skill).toList(),
    );
  }

  void updateJobTitle(String value) {
    state = state.copyWith(jobTitle: value);
  }

  void updateExperience(int value) {
    state = state.copyWith(experience: value);
  }
}
