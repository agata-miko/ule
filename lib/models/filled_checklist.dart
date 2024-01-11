import 'package:uuid/uuid.dart';

class FilledChecklist {
  String checklistId;
  String hiveId;
  DateTime checklistDate;

  FilledChecklist(
      {required this.hiveId, required this.checklistDate, String? checklistId})
      : checklistId = checklistId ?? generateUniqueId();

  static String generateUniqueId() {
    var uuid = const Uuid();
    return uuid.v4();
  }

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
