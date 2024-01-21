import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pszczoly_v3/models/question.dart';
import 'package:pszczoly_v3/models/question_answer.dart';
import 'package:pszczoly_v3/providers/hive_list_provider.dart';
import 'package:pszczoly_v3/data/checklist_questions_data.dart';

class FilledChecklistDisplay extends ConsumerStatefulWidget {
  const FilledChecklistDisplay({super.key, required this.checklistId});

  final String checklistId;

  @override
  ConsumerState createState() => ChecklistState();
}

class ChecklistState extends ConsumerState<FilledChecklistDisplay> {
  final checklistQuestions1 = getChecklistQuestions();
  late List<QuestionAnswer> questionAnswerForAChecklist;

  @override
  Widget build(BuildContext context) {
    Future<List<Map<String, dynamic>>> questionAnswersList = ref
        .read(databaseProvider)
        .getQuestionAnswersForChecklist(widget.checklistId);

    return FutureBuilder(
      future: questionAnswersList,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(
            child: Text(
              'Ups... Wygląda na to, że ta checklista została zapisana bez odpowiedzi.',
              textAlign: TextAlign.center,
            ),
          );
        } else {
          questionAnswerForAChecklist = snapshot.data!
              .map((row) => QuestionAnswer(
                    questionId: row['questionId'] as String,
                    answerType: row['answerType'] as dynamic,
                    checklistId: row['checklistId'] as String,
                    answer: row['answer'] as dynamic,
                    questionAnswerId: row['questionAnswerId'] as String,
                  ))
              .toList();
        }

        return ListView.builder(itemCount: checklistQuestions1.length, itemBuilder: (context, index) {
          Question currentQuestion = checklistQuestions1[index];
          QuestionAnswer? currentAnswer = questionAnswerForAChecklist.firstWhere(
                (answer) => answer.questionId == currentQuestion.id,
            orElse: () => QuestionAnswer(
              questionId: currentQuestion.id,
              answerType: null, // Set your default answerType here if needed
              checklistId: widget.checklistId,
              answer: 'Brak danych',
              questionAnswerId: 'N/A',
            ),
          );
          return ListTile(
            title: Text(currentQuestion.text),
            subtitle: Text(currentAnswer.answer, style: TextStyle(color: currentAnswer.answer == 'Brak danych' ? Colors.grey[300] : null),),
          );
        });
        //Second approach - displaying only the answered questions - need to choose which one id preffered
        // return ListView.builder(
        //   itemCount: min(
        //       checklistQuestions1.length, questionAnswerForAChecklist.length),
        //   itemBuilder: (context, index) {
        //     QuestionAnswer currentAnswer = questionAnswerForAChecklist[index];
        //     Question currentQuestion = checklistQuestions1.firstWhere(
        //         (question) => question.id == currentAnswer.questionId);
        //     return ListTile(
        //       title: Text(currentQuestion.text,
        //           style: const TextStyle(fontWeight: FontWeight.bold)),
        //       subtitle: Text(currentAnswer.answer),
        //     );
        //   },
        // );
      },
    );
  }
}
