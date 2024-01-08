import 'dart:io';
import 'package:path_provider/path_provider.dart' as syspaths;
import 'package:path/path.dart' as path;

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pszczoly_v3/models/hive.dart';
import 'package:pszczoly_v3/services/database_helper.dart';

final hiveDataProvider =
StateNotifierProvider<HiveDataNotifier, List<Hive>>((ref) => HiveDataNotifier()); //this is hives list provider?
final databaseProvider = Provider<DatabaseHelper>((ref) => DatabaseHelper());

class HiveDataNotifier extends StateNotifier<List<Hive>> {
  final DatabaseHelper _databaseHelper = DatabaseHelper();
  HiveDataNotifier() : super([]);

void addHive({File? photo, hiveName}) async {
  final appDir = await syspaths.getApplicationDocumentsDirectory();
  final fileName = path.basename(photo!.path);
  final copiedPhoto = await photo.copy('${appDir.path}/$fileName');

  final newHive = Hive(photo: copiedPhoto, hiveName: hiveName);
  await _databaseHelper.insertHive(newHive.toJson());

  final allHives = await _databaseHelper.getAllHives();
  print('All Hives in the Database: $allHives');

  state = [...state, newHive];

}

  void updateHivePhoto(String hiveName, File? photo) {
    state = [
      for (var hive in state)
        if (hive.hiveName == hiveName)
          Hive(hiveName: hiveName, photo: photo)

        else
          hive,
    ];
  }
}


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

