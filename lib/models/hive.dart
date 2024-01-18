import 'dart:io';
import 'package:uuid/uuid.dart';

String generateUniqueId() {
  var uuid = const Uuid();
  return uuid.v4();
}

class Hive {
  String hiveId;
  String hiveName;
  File? photo;
  String? notes;


  Hive ({this.photo, required this.hiveName, this.notes, String? hiveId}) : hiveId = hiveId ?? generateUniqueId();

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

