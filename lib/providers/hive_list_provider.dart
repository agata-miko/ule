import 'dart:io';
import 'package:path_provider/path_provider.dart' as syspaths;
import 'package:path/path.dart' as path;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pszczoly_v3/models/hive.dart';


final hiveDataProvider = StateNotifierProvider<HiveDataNotifier, List<Hive>>(
      (ref) => HiveDataNotifier(),
);

class HiveDataNotifier extends StateNotifier<List<Hive>> {

  HiveDataNotifier() : super([]);

  Future<void> addHive({File? photo, hiveName}) async {
    final appDir = await syspaths.getApplicationDocumentsDirectory();
    final fileName = path.basename(photo?.path ?? '');
    final copiedPhoto = await photo?.copy('${appDir.path}/$fileName');

    final newHive = Hive(photo: copiedPhoto, hiveName: hiveName);
    state = [...state, newHive];
  }

  Future<void> updateHivePhoto(String hiveName, File? photo) async {
    state = [
      for (var hive in state)
        if (hive.hiveName == hiveName)
          Hive(
            hiveName: hiveName,
            photo: photo,
            hiveId: hive.hiveId,
          )
        else
          hive,
    ];
  }
  Future<void> deleteHive(int hiveId) async {
    state = state.where((hive) => hive.hiveId != hiveId).toList();
  }
} 
