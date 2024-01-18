
// await db.execute('''
//       CREATE TABLE Checklists (
//         checklistId TEXT PRIMARY KEY,
//         hiveId TEXT,
//         checklistDate INTEGER,
//         FOREIGN KEY (hiveId) REFERENCES Hive(hiveId)
//       )
//     ''');

class Checklist {
  final String checklistId;
  final String hiveId;
  final DateTime checklistDate;

  Checklist({required this.checklistId, required this.hiveId, required this.checklistDate,});

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

