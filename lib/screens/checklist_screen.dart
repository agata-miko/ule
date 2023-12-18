import 'package:flutter/material.dart';
import 'package:pszczoly_v3/data/checklist_questions_data.dart';
import 'package:pszczoly_v3/models/question.dart';
import 'package:pszczoly_v3/widgets/checklist.dart';


class ChecklistScreen extends StatefulWidget {
  const ChecklistScreen({super.key});

  @override
  State<ChecklistScreen> createState() => _ChecklistScreenState();
}

class _ChecklistScreenState extends State<ChecklistScreen> {
  DateTime checklistDate = DateTime.now();
  final List<Question> questions = checklistQuestions;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('numer ula ${checklistDate.day}/${checklistDate.month}/${checklistDate.year}'), //different way to display data in dd/mm/yyyy
      ),
      body: Expanded(
        child: Column(
          children: <Widget>[
            Expanded(child: Checklist(questions: questions,)),
            ElevatedButton(onPressed: null, child: Text('Zapisz')),
          ],
        ),
      ),
    );
  }
}
