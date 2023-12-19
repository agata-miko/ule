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

  Hive ({this.photo, required this.hiveName, this.notes}) : hiveId = generateUniqueId();
}