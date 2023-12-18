class ChecklistResponses {
  int hiveId;
  DateTime checklistDate;
  Map<String, dynamic> answers;

  ChecklistResponses({
    required this.hiveId,
    required this.checklistDate,
    required this.answers,
  });
}
