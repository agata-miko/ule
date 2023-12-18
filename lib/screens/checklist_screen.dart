import 'package:flutter/material.dart';
import 'package:pszczoly_v3/widgets/checklist.dart';


class ChecklistScreen extends StatefulWidget {
  const ChecklistScreen({super.key});

  @override
  State<ChecklistScreen> createState() => _ChecklistScreenState();
}

class _ChecklistScreenState extends State<ChecklistScreen> {
  DateTime checklistDate = DateTime.now();

  final String hiveName = 'numer ula';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hive Mate'),
      ),
      body: Expanded(
        child: Column(
          children: <Widget>[
            Text(hiveName),
            // jak wyswietlic date?? intl??
            Text('${checklistDate.day}/${checklistDate.month}/${checklistDate.year}'),
            Expanded(child: Checklist()),
            const ElevatedButton(onPressed: null, child: Text('Zapisz')),
          ],
        ),
      ),
    );
  }
}
