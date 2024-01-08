import 'package:pszczoly_v3/models/question.dart';
import 'package:uuid/uuid.dart';

class ChecklistResponses {
  String checklistId;
  int hiveId;
  DateTime checklistDate;
  List<Question> answers;

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
      'answers': answers.map((question) => {
        'questionId': question.id,
        'responseType': question.responseType.toString().split('.').last,
        'response': question.response,
      } as MapEntry Function(String key, dynamic value)).toList(),
    };
  }
}

