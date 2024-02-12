class QuestionAnswer {
  int? questionAnswerId;
  int? checklistId;
  String questionId;
  dynamic answerType;
  dynamic answer;

  QuestionAnswer({this.answer, required this.checklistId, required this.questionId, required this.answerType,
      this.questionAnswerId});

  void updateChecklistId (int checklistId) {
    this.checklistId = checklistId;
  }

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
