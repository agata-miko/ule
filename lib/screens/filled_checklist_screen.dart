import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:pszczoly_v3/widgets/filled_checklist.dart';


class FilledChecklistScreen extends ConsumerStatefulWidget {
  const FilledChecklistScreen(
      {super.key,
      required this.hiveId,
      required this.checklistId,
      required this.checklistDate,
      required this.hiveName});

  final String hiveId;
  final String checklistId;
  final DateTime checklistDate;
  final String hiveName;

  @override
  ConsumerState<FilledChecklistScreen> createState() => _ChecklistScreenState();
}

class _ChecklistScreenState extends ConsumerState<FilledChecklistScreen> {
  final DateFormat _dateFormat = DateFormat('dd/MM/yyyy');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: FittedBox(
        fit: BoxFit.scaleDown,
        child: Text(
          '${widget.hiveName} ${_dateFormat.format(widget.checklistDate)}',
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
      )),
      //different way to display data in dd/mm/yyyy???
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FilledChecklistDisplay(checklistId: widget.checklistId,),
      ),
    );
  }
}