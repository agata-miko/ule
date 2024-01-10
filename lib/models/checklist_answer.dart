import 'package:uuid/uuid.dart';

String generateUniqueId() {
  var uuid = const Uuid();
  return uuid.v4();
}

class ChecklistAnswer {
  String checklistAnswerId;
  String checklistId;
  String questionId;
  dynamic answer;

  ChecklistAnswer(
      this.answer, this.checklistId, this.questionId, String? checklistAnswerId)
      : checklistAnswerId = checklistAnswerId ?? generateUniqueId();

  Map<String, dynamic> toJson() {
    return {
      'checklistAnswerId': checklistAnswerId,
      'checklistId': checklistId,
      'questionId': questionId,
      'answer': answer,
    };
  }
}
