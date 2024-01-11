import 'package:uuid/uuid.dart';

String generateUniqueId() {
  var uuid = const Uuid();
  return uuid.v4();
}

class QuestionAnswer {
  String questionAnswerId;
  String checklistId;
  String questionId;
  dynamic answerType;
  dynamic answer;

  QuestionAnswer({this.answer, required this.checklistId, required this.questionId, required this.answerType,
      String? questionAnswerId})
      : questionAnswerId = questionAnswerId ?? generateUniqueId();

  Map<String, dynamic> toJson() {
    return {
      'questionAnswerId': questionAnswerId,
      'checklistId': checklistId,
      'questionId': questionId,
      'answerType': answerType.toString(),
      'answer': answer.toString(),
    };
  }

  factory QuestionAnswer.fromJson(Map<String, dynamic> json) =>
      QuestionAnswer(
          answer: json['answer'],
          checklistId: json['checklistId'],
          questionId: json['questionId'],
          answerType: json['answerType'],
          questionAnswerId: json['questionAnswerId']);
}
