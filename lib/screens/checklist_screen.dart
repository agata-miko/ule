import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:pszczoly_v3/models/filled_checklist.dart';
import 'package:pszczoly_v3/providers/hive_list_provider.dart';
import 'package:pszczoly_v3/widgets/checklist.dart';

class ChecklistScreen extends ConsumerStatefulWidget {
  const ChecklistScreen(
      {super.key, required this.hiveId, required this.hiveName});

  final String hiveId;
  final String hiveName;

  @override
  ConsumerState<ChecklistScreen> createState() => _ChecklistScreenState();
}

class _ChecklistScreenState extends ConsumerState<ChecklistScreen> {
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
                      print(ref.read(databaseProvider).getChecklists());
                      Navigator.of(context).pop();
                    },
                    child: const Text('Cofnij')),
                ElevatedButton(
                    onPressed: () {
                      ref.read(databaseProvider).insertChecklist(
                          FilledChecklist(
                                  hiveId: widget.hiveId,
                                  checklistDate: checklistDate)
                              .toJson());
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
