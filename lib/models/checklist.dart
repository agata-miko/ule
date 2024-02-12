class Checklist {
  final int? checklistId;
  final int hiveId;
  final DateTime checklistDate;

  Checklist({this.checklistId, required this.hiveId, required this.checklistDate,});

  Map<String, dynamic> toJson() {
    return {
      'checklistId': checklistId,
      'hiveId': hiveId,
      'checklistDate': checklistDate as String,
    };
  }
  factory Checklist.fromJson(Map<String, dynamic> json) => Checklist(
    checklistId: json['checklist'],
    hiveId: json['hiveId'],
    checklistDate: json['checklistDate'] as DateTime,
  );
}

