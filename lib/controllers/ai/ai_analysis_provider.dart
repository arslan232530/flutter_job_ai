import 'package:flutter_riverpod/legacy.dart';
import 'package:job_board/controllers/ai/ai_analysis_notifier.dart';
import 'package:job_board/controllers/ai/ai_analysis_state.dart';

final aiAnalysisProvider =
    StateNotifierProvider<AiAnalysisNotifier, AiAnalysisState>(
      (ref) => AiAnalysisNotifier(),
    );
