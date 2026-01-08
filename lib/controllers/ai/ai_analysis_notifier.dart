import 'package:flutter_riverpod/legacy.dart';
import 'package:job_board/controllers/ai/ai_analysis_state.dart';
import 'package:job_board/services/ai/aiservice.dart';

class AiAnalysisNotifier extends StateNotifier<AiAnalysisState> {
  AiAnalysisNotifier() : super(const AiAnalysisState());

  String _normalize(String text) {
    return text.toLowerCase().replaceAll(RegExp(r'[^a-z0-9 ]'), '').trim();
  }

  Future<void> analyzeMock({
    required List<String> userSkills,
    required List<String> jobRequirements,
  }) async {
    state = state.copyWith(isLoading: true, error: null, analysis: null);

    final matchedSkills = _extractMatchedSkills(
      userSkills: userSkills,
      jobRequirements: jobRequirements,
    );

    await Future.delayed(const Duration(seconds: 2));

    print(matchedSkills);

    final missingSkills = jobRequirements.where((req) {
      return !matchedSkills.any(
        (skill) => req.toLowerCase().contains(skill.toLowerCase()),
      );
    }).toList();

    final matchPercentage = jobRequirements.isEmpty
        ? 0
        : ((matchedSkills.length / jobRequirements.length) * 100).round();

    final isEligible = matchPercentage >= 60;

    state = state.copyWith(
      isLoading: false,
      analysis: {
        'isEligible': isEligible,
        'matchPercentage': matchPercentage,
        'matchedSkills': matchedSkills,
        'missingSkills': missingSkills,
        'summary': isEligible
            ? 'Your skills align well with this job role.'
            : 'You are missing key skills required for this position.',
      },
    );
  }

  Future<void> analyzeWithBackend({
    required List<String> userSkills,
    required List<String> jobRequirements,
  }) async {
    state = state.copyWith(isLoading: true, error: null, analysis: null);

    try {
      final result = await AiService.analyze(
        userSkills: userSkills,
        jobRequirements: jobRequirements,
      );

      await Future.delayed(const Duration(seconds: 2));

      state = state.copyWith(isLoading: false, analysis: result);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  List<String> _extractMatchedSkills({
    required List<String> userSkills,
    required List<String> jobRequirements,
  }) {
    final matched = <String>[];

    for (final skill in userSkills) {
      final normalizedSkill = _normalize(skill);

      for (final req in jobRequirements) {
        final normalizedReq = _normalize(req);
        print('Checking skill "$normalizedSkill" against "$normalizedReq"');
        if (normalizedReq.contains(normalizedSkill)) {
          matched.add(skill);
          break;
        }
      }
    }

    return matched;
  }
}
