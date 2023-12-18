import 'dart:io';
import 'package:uuid/uuid.dart';

String generateUniqueId() {
  var uuid = const Uuid();
  return uuid.v4();
}

class Hive {
  String hiveId;
  File? photo;

  Hive ({this.photo}) : hiveId = generateUniqueId();
}