import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:modern_themes/modern_themes_comps.dart';
import 'package:pszczoly_v3/models/filled_checklist.dart';
import 'package:pszczoly_v3/models/question.dart';
import 'package:pszczoly_v3/models/question_answer.dart';
import 'package:pszczoly_v3/providers/hive_list_provider.dart';
import 'package:pszczoly_v3/widgets/percentage_slider.dart';
import 'package:pszczoly_v3/data/checklist_questions_data.dart';

class Checklist extends ConsumerStatefulWidget {
  Checklist({Key? key, required this.hiveId, required this.checklistDate})
      : checklistId = generateUniqueId(),
        super(key: key);

  final String hiveId;
  final DateTime checklistDate;
  final String checklistId;

  @override
  ConsumerState createState() => ChecklistState();
}

class ChecklistState extends ConsumerState<Checklist> {
  final checklistQuestions1 = getChecklistQuestions();
  Map<String, dynamic> questionAnswersMap = {};
  final List<QuestionAnswer> finalQuestionAnswerList = [];

  void addOrUpdateFinalAnswers() {
    for (QuestionAnswer qa in questionAnswersMap.values) {
      final existingIndex = finalQuestionAnswerList
          .indexWhere((item) => item.questionId == qa.questionId);
      if (existingIndex != -1) {
        finalQuestionAnswerList[existingIndex] = qa;
      } else {
        finalQuestionAnswerList.add(qa);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: checklistQuestions1.length,
            itemBuilder: (context, index) {
              return buildQuestionCard(checklistQuestions1[index]);
            },
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Cofnij')),
            ElevatedButton(
                onPressed: () {
                  addOrUpdateFinalAnswers();
                  ref.read(databaseProvider).insertChecklist(FilledChecklist(
                        hiveId: widget.hiveId,
                        checklistDate: widget.checklistDate,
                        checklistId: widget.checklistId,
                      ).toJson());
                  for (QuestionAnswer qa in questionAnswersMap.values) {
                    ref
                        .read(databaseProvider)
                        .insertQuestionAnswer(qa.toJson());
                  }
                  ref.read(databaseProvider).printTables();
                  Navigator.of(context).pop();
                  finalQuestionAnswerList.clear();
                },
                child: const Text('Zapisz')),
          ],
        ),
      ],
    );
  }

  Widget buildQuestionCard(Question question) {
    return Card(
      elevation: 0,
      color: Theme.of(context).colorScheme.primaryContainer,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              question.text.toUpperCase(),
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!,
                  // .copyWith(fontWeight: FontWeight.bold),
              textAlign: TextAlign.start,
            ),
          ),
          buildResponseWidget(question, questionAnswersMap[question.id]),
        Divider(thickness: 0.1),],
      ),
    );
  }

  Widget buildResponseWidget(Question question, dynamic questionAnswer) {
    switch (question.responseType) {
      case ResponseType.yesNo:
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Radio(
              value: true,
              groupValue: questionAnswer is QuestionAnswer
                  ? (questionAnswer).answer
                  : null,
              onChanged: (value) {
                setState(() {
                  questionAnswersMap[question.id] = QuestionAnswer(
                    checklistId: widget.checklistId,
                    questionId: question.id,
                    answerType: ResponseType.yesNo.toString(),
                    answer: value,
                  );
                });
              },
            ),
            const Text('Tak'),
            Radio(
              value: false,
              groupValue: questionAnswer is QuestionAnswer
                  ? (questionAnswer).answer
                  : null,
              onChanged: (value) {
                setState(() {
                  questionAnswersMap[question.id] = QuestionAnswer(
                    checklistId: widget.checklistId,
                    questionId: question.id,
                    answerType: ResponseType.yesNo.toString(),
                    answer: value,
                  );
                });
              },
            ),
            const Text('Nie'),
          ],
        );
      case ResponseType.text:
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            style: const TextStyle(height: 1),
            decoration: InputDecoration(
              hintText: 'Odpowiedź',
              hintStyle: Theme.of(context).textTheme.bodyMedium,
              filled: true,
              fillColor: Colors.grey[50],
              border: InputBorder.none,
            ),
            onChanged: (String value) {
              setState(() {
                questionAnswersMap[question.id] = QuestionAnswer(
                  checklistId: widget.checklistId,
                  questionId: question.id,
                  answerType: ResponseType.text.toString(),
                  answer: value,
                );
              });
            },
          ),
        );
      case ResponseType.percentage:
        return PercentageSlider(
          selectedPercentage: questionAnswer is QuestionAnswer
              ? (questionAnswer).answer ?? 0
              : 0,
          onChanged: (value) {
            setState(() {
              questionAnswersMap[question.id] = QuestionAnswer(
                checklistId: widget.checklistId,
                questionId: question.id,
                answerType: ResponseType.percentage.toString(),
                answer: value,
              );
            });
          },
        );
      default:
        return Container(); // Return an empty container for unknown type
    }
  }
}
