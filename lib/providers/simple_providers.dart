import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pszczoly_v3/data/checklist_questions_data.dart';
import 'package:pszczoly_v3/models/question.dart';
import 'package:pszczoly_v3/widgets/checklist.dart';

// final questionsListProvider = StateNotifierProvider<QuestionsListNotifier, List<Question>>((ref) => QuestionsListNotifier());
//
// class QuestionsListNotifier extends StateNotifier<List<Question>> {
//   QuestionsListNotifier() : super(checklistQuestions);
// }
//
// final questionsProvider = Provider.autoDispose<List<Question>>((ref) {
//   return checklistQuestions;
// });

final selectedImageProvider =
    StateNotifierProvider<SelectedImageNotifier, File?>(
        (ref) => SelectedImageNotifier());

class SelectedImageNotifier extends StateNotifier<File?> {
  SelectedImageNotifier() : super(null);

  void setSelectedImage(File image) {
    state = image;
  }
}



