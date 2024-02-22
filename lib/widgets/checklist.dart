import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pszczoly_v3/models/filled_checklist.dart';
import 'package:pszczoly_v3/models/question.dart';
import 'package:pszczoly_v3/models/question_answer.dart';
import 'package:pszczoly_v3/providers/database_provider.dart';
import 'package:pszczoly_v3/widgets/percentage_slider.dart';
import 'package:pszczoly_v3/data/checklist_questions_data.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Checklist extends ConsumerStatefulWidget {
  const Checklist(
      {super.key,
      required this.hiveId,
      required this.checklistDate,
      this.checklistId});

  final int hiveId;
  final DateTime checklistDate;
  final int? checklistId;

  @override
  ConsumerState createState() => ChecklistState();
}

class ChecklistState extends ConsumerState<Checklist> {
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
    final checklistQuestions1 = getChecklistQuestions(context);

    bool hasUnansweredQuestions() {
      final unansweredQuestions = checklistQuestions1
          .where((question) => questionAnswersMap[question.id] == null)
          .toList();
      return unansweredQuestions.isNotEmpty;
    }

    void saveChecklist() async {
      addOrUpdateFinalAnswers();
      int checklistId =
          await ref.read(databaseProvider).insertChecklist(FilledChecklist(
                hiveId: widget.hiveId,
                checklistDate: widget.checklistDate,
              ).toJson());
      for (QuestionAnswer qa in questionAnswersMap.values) {
        qa.updateChecklistId(checklistId);
        ref.read(databaseProvider).insertQuestionAnswer(qa.toJson());
      }
      // ref.read(databaseProvider).printTables();
      if (mounted) {
        Navigator.of(context).pop();
      }
      finalQuestionAnswerList.clear();
    }

    Future<void> showIncompleteChecklistDialog(BuildContext context) async {
      return showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(AppLocalizations.of(context)!.incompleteChecklist),
              content: Text(
                  AppLocalizations.of(context)!.incompleteChecklistContent),
              actions: <Widget>[
                ButtonBar(
                  alignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        AppLocalizations.of(context)!.backToChecklist,
                        style: const TextStyle(color: Color(0xFF1B2805)),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        saveChecklist();
                        Navigator.of(context).pop();
                      },
                      child: Text(AppLocalizations.of(context)!.save,
                          style: const TextStyle(color: Color(0xFF1B2805))),
                    ),
                  ],
                ),
              ],
            );
          });
    }

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
                child: Text(
                  AppLocalizations.of(context)!.back,
                  style: const TextStyle(color: Color(0xFF1B2805)),
                )),
            ElevatedButton(
                onPressed: () async {
                  if (hasUnansweredQuestions()) {
                    await showIncompleteChecklistDialog(context);
                  } else {
                    saveChecklist();
                  }
                },
                child: Text(AppLocalizations.of(context)!.save)),
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
            padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.02),
            child: Text(
              question.text.toUpperCase(),
              style: Theme.of(context).textTheme.bodyMedium!,
              // .copyWith(fontWeight: FontWeight.bold),
              textAlign: TextAlign.start,
            ),
          ),
          buildResponseWidget(question, questionAnswersMap[question.id]),
          const Divider(thickness: 0.1),
        ],
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
              key: Key('${question.id}_yes'),
              activeColor: const Color(0xFF233406),
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
            Text(AppLocalizations.of(context)!.yes),
            Radio(
              key: Key('${question.id}_no'),
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
            Text(AppLocalizations.of(context)!.no),
          ],
        );
      case ResponseType.text:
        return Padding(
          padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.02),
          child: TextField(
            key: Key('${question.id}_text'),
            style: const TextStyle(height: 1),
            decoration: InputDecoration(
              hintText: AppLocalizations.of(context)!.answerHint,
              hintStyle: Theme.of(context).textTheme.bodyMedium,
              filled: true,
              fillColor: const Color(0xFF233406).withOpacity(0.1),
              border: InputBorder.none,
            ),
            onChanged: (String value) {
              setState(() {
                questionAnswersMap[question.id] = QuestionAnswer(
                  checklistId: widget.checklistId!,
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
