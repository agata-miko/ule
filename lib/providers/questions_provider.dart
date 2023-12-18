import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pszczoly_v3/data/checklist_questions_data.dart';

final questionsProvider = Provider((ref) {
  return checklistQuestions;
});