import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pszczoly_v3/models/hive.dart';

final hiveDataProvider =
StateNotifierProvider<HiveDataNotifier, List<Hive>>((ref) => HiveDataNotifier());

class HiveDataNotifier extends StateNotifier<List<Hive>> {
  HiveDataNotifier() : super([]);

void addHive({File? photo, hiveName}) {
  final newHive = Hive(photo: photo, hiveName: hiveName);
  state = [...state, newHive];
}}

// class HiveData {
//   List<Hive> _hives = [];
//
//   List<Hive> get hives => _hives;
//
//   void addHive(Hive hive) {
//     _hives.add(hive);
//   }
//
//   List<Hive> getAllHives() {
//     return _hives;
//   }
// }

