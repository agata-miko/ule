import 'package:uuid/uuid.dart';

class ChecklistResponses {
  String checklistId;
  int hiveId;
  DateTime checklistDate;
  Map<String, dynamic> answers;

  ChecklistResponses({
    required this.hiveId,
    required this.checklistDate,
    required this.answers,
  }) : checklistId = generateUniqueId();

  static String generateUniqueId() {
    var uuid = const Uuid();
    return uuid.v4();
  }

  Map<String, dynamic> toJson() {
    return {
      'checklistId': checklistId,
      'hiveId': hiveId,
      'checklistDate': checklistDate.millisecondsSinceEpoch,
      'answers': answers,
    };
  }
}

