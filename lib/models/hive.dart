import 'dart:io';

class Hive {
  int? hiveId;
  String hiveName;
  File? photo;
  String? notes;


  Hive ({this.photo, required this.hiveName, this.notes, this.hiveId});
  Map<String, dynamic> toJson() {
    return {
      'hiveId': hiveId,
      'hiveName': hiveName,
      'photoPath': photo?.path,
      'note': notes,
    };
  }
    factory Hive.fromJson(Map<String, dynamic> json) => Hive(
        hiveId: json['hiveId'],
        hiveName: json['hiveName'],
        photo: json['photoPath'] != null ? File(json['photoPath']) : null,
        notes: json['note'],
    );

}

