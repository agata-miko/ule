import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pszczoly_v3/models/hive.dart';

final hiveDataProvider =
StateNotifierProvider<HiveDataNotifier, List<Hive>>((ref) => HiveDataNotifier());

class HiveDataNotifier extends StateNotifier<List<Hive>> {
  HiveDataNotifier() : super([]);

void addHive({File? photo}) {
  final newHive = Hive(photo: photo);
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

