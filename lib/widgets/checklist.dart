import 'package:flutter/material.dart';
import 'package:pszczoly_v3/models/question.dart';
import 'package:pszczoly_v3/data/checklist_questions_data.dart';

class Checklist extends StatefulWidget {
  Checklist({super.key, required this.questions});

  List<Question> questions = checklistQuestions;

  @override
  ChecklistState createState() => ChecklistState();
}

class ChecklistState extends State<Checklist> {

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.questions.length,
      itemBuilder: (context, index) {
        return buildQuestionCard(widget.questions[index]);
      },
    );
  }

  Widget buildQuestionCard(Question question) {
    return Card(
      child: Column(
        children: [
          Text(question.text),
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
            const Text('Yes'),
            Radio(
              value: false,
              groupValue: question.response,
              onChanged: (value) {
                setState(() {
                  question.response = value;
                });
              },
            ),
            const Text('No'),
          ],
        );
      case ResponseType.text:
        return TextField(
          onChanged: (String value) {
            setState(() {
              question.response = value;
            });
          },
        );
      case ResponseType.percentage:
        return Slider(value: question.response ?? 0.0, onChanged: (double value) {
          setState(() {
            question.response = value;
          });
        });
    // Add cases for other response types as needed
      default:
        return Container(); // Return an empty container for unknown types
    }
  }
}
