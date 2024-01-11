import 'package:uuid/uuid.dart';

class FilledChecklist {
  String checklistId;
  String hiveId;
  DateTime checklistDate;

  FilledChecklist(
      {required this.hiveId, required this.checklistDate, required this.checklistId});

  Map<String, dynamic> toJson() {
    return {
      'checklistId': checklistId,
      'hiveId': hiveId,
      'checklistDate': checklistDate.millisecondsSinceEpoch,
    };
  }

  factory FilledChecklist.fromJson(Map<String, dynamic> json) =>
      FilledChecklist(
        checklistId: json['checklistId'],
        hiveId: json['hiveId'],
        checklistDate: json['checklistDate'],
      );
}
