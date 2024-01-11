import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pszczoly_v3/widgets/checklist.dart';

class ChecklistScreen extends StatefulWidget {
  const ChecklistScreen(
      {super.key, required this.hiveId, required this.hiveName});

  final String hiveId;
  final String hiveName;

  @override
  State<ChecklistScreen> createState() => _ChecklistScreenState();
}

class _ChecklistScreenState extends State<ChecklistScreen> {
  DateTime checklistDate = DateTime.now();
  final DateFormat _dateFormat = DateFormat('dd/MM/yyyy');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
            title: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                        '${widget.hiveName} ${_dateFormat.format(checklistDate)}',
                        style: Theme.of(context).appBarTheme.titleTextStyle,
                      ),
            )),
        //different way to display data in dd/mm/yyyy???
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            const Expanded(child: Checklist()),
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
                      Navigator.of(context).pop();
                    },
                    child: const Text('Zapisz')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
