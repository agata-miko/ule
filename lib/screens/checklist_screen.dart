import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:pszczoly_v3/widgets/checklist.dart';
import 'package:uuid/uuid.dart';

class ChecklistScreen extends ConsumerStatefulWidget {
  const ChecklistScreen(
      {super.key, required this.hiveId, required this.hiveName});

  final int hiveId;
  final String hiveName;

  @override
  ConsumerState<ChecklistScreen> createState() => _ChecklistScreenState();
}

class _ChecklistScreenState extends ConsumerState<ChecklistScreen> {

  DateTime checklistDate = DateTime.now();
  final DateFormat _dateFormat = DateFormat('dd/MM/yyyy');

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
          padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.04),
          child: Column(
            children: <Widget>[
              Expanded(child: Checklist(key: ValueKey(const Uuid().v4), hiveId: widget.hiveId, checklistDate: checklistDate,)),
            ],
          ),
        ),
      ),
    );
  }
}
