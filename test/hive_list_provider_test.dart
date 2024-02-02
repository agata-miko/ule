import 'dart:io';
import 'package:pszczoly_v3/models/hive.dart';
import 'package:test/test.dart';
import 'package:mockito/mockito.dart';
import 'package:pszczoly_v3/providers/hive_list_provider.dart';

class MockFile extends Mock implements File {
    @override
    final String path;

    MockFile({String? path}) : path = path ?? 'default_path';
}

void main() {
    group('hiveDataNotifier addHive tests - state only', () {
        test('addHive should add new Hive to the state', () async {
            final hiveDataNotifier = HiveDataNotifier();
            final mockPhoto = MockFile();
            const hiveName = 'testHive';

            final newHive = Hive(hiveName: hiveName, photo: mockPhoto);

           hiveDataNotifier.state = [...hiveDataNotifier.state, newHive];
           expect(hiveDataNotifier.state, contains(newHive));
        });


    });
}