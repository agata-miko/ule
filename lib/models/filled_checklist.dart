class FilledChecklist {
  int? checklistId;
  int hiveId;
  DateTime checklistDate;

  FilledChecklist(
      {required this.hiveId, required this.checklistDate, this.checklistId});

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
