import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pszczoly_v3/models/question.dart';
import 'package:pszczoly_v3/providers/simple_providers.dart';
import 'package:pszczoly_v3/widgets/percentage_slider.dart';

class Checklist extends ConsumerStatefulWidget {
  const Checklist({super.key});

  @override
  ConsumerState createState() => ChecklistState();
}

class ChecklistState extends ConsumerState<Checklist> {
  @override
  Widget build(BuildContext context) {
    final checklistQuestions = ref.watch(questionsProvider);


    return ListView.builder(
      itemCount: checklistQuestions.length,
      itemBuilder: (context, index) {
        return buildQuestionCard(checklistQuestions[index]);
      },
    );
  }

  Widget buildQuestionCard(Question question) {
    return Card(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(question.text),
          ),
          buildResponseWidget(question),
        ],
      ),
    );
  }

  Widget buildResponseWidget(Question question) {
    switch (question.responseType) {
      case ResponseType.yesNo:
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Radio(
              value: true,
              groupValue: question.response,
              onChanged: (value) {
                setState(() {
                  question.response = value;
                });
              },
            ),
            const Text('Tak'),
            Radio(
              value: false,
              groupValue: question.response,
              onChanged: (value) {
                setState(() {
                  question.response = value;
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
            decoration: const InputDecoration(
                hintText: 'Odpowiedź',
                hintStyle: TextStyle(fontSize: 12, color: Colors.grey)),
            onChanged: (String value) {
              setState(() {
                question.response = value;
              });
            },
          ),
        );
      case ResponseType.percentage:
        return PercentageSlider();
      default:
        return Container(); // Return an empty container for unknown types
    }
  }
}
