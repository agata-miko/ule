import 'package:flutter/material.dart';
import 'package:pszczoly_v3/widgets/checklist.dart';

class ChecklistScreen extends StatefulWidget {
  const ChecklistScreen({super.key});

  @override
  State<ChecklistScreen> createState() => _ChecklistScreenState();
}

class _ChecklistScreenState extends State<ChecklistScreen> {
  DateTime checklistDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            'numer ula ${checklistDate.day}/${checklistDate.month}/${checklistDate.year}'), //different way to display data in dd/mm/yyyy
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            const Expanded(child: Checklist()),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                TextButton(onPressed: () {Navigator.of(context).pop();}, child: const Text('Cofnij')),
                ElevatedButton(onPressed: () {Navigator.of(context).pop();}, child: const Text('Zapisz')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
