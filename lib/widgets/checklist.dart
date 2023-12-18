import 'package:flutter/material.dart';
import 'package:pszczoly_v3/models/question.dart';

class Checklist extends StatefulWidget {
  @override
  _ChecklistState createState() => _ChecklistState();
}

class _ChecklistState extends State<Checklist> {
  List<Question> questions = [
    Question(text: 'Question 1: Yes/No', responseType: ResponseType.yesNo),
    Question(text: 'Question 2: Text Response', responseType: ResponseType.text),
    Question(text: 'Question 3: Percentage', responseType: ResponseType.percentage),
    // Add more questions as needed
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: questions.length,
      itemBuilder: (context, index) {
        return buildQuestionCard(questions[index]);
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
        return Switch(value: question.response ?? false, onChanged: (bool value) {
          setState(() {
            question.response = value;
          });
        });
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
