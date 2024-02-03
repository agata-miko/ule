import 'dart:io';
import 'dart:math';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:pszczoly_v3/models/hive.dart';
import 'package:pszczoly_v3/providers/hive_list_provider.dart';

class MockFile extends Mock implements File {
  @override
  Future<File> copy(String string) {
    return Future.value(MockFile());
  }

  @override
  final String path;

  MockFile({String? path}) : path = path ?? 'default_path/path/path';
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(() async {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
        const MethodChannel('plugins.flutter.io/path_provider'),
            (MethodCall methodCall) {
          if (methodCall.method == 'getApplicationDocumentsDirectory') {
            return Future.value('C:/Users/mikol/Downloads/');
          }
          return null;
        });
  });

  group('hiveDataNotifier addHive tests', () {
      test('addHive should add new Hive to the state', () async {
          final container = ProviderContainer();
          final mockPhoto = MockFile();
          const hiveName = 'testHive';

          await container.read(hiveDataProvider.notifier).addHive(
              hiveName: hiveName, photo: mockPhoto);
          expect(container
              .read(hiveDataProvider.notifier)
              .state
              .first
              .hiveName, hiveName);
      });
      test('addHive should add multiple hives to the state', () async {
          final container = ProviderContainer();
          final mockPhoto = MockFile();
          const hiveName1 = 'testHive1';
          const hiveName2 = 'testHive2';
          const hiveName3 = 'testHive3';

          await container.read(hiveDataProvider.notifier).addHive(
              hiveName: hiveName1, photo: mockPhoto);
          await container.read(hiveDataProvider.notifier).addHive(
              hiveName: hiveName2, photo: mockPhoto);
          await container.read(hiveDataProvider.notifier).addHive(
              hiveName: hiveName3, photo: mockPhoto);

          expect(container
              .read(hiveDataProvider.notifier)
              .state
              .first
              .hiveName, hiveName1);
          expect(container
              .read(hiveDataProvider.notifier)
              .state[1].hiveName, hiveName2);
          expect(container
              .read(hiveDataProvider.notifier)
              .state[2].hiveName, hiveName3);
      });
      test('addHive should add Hive without photo to the state', () async {
          final container = ProviderContainer();
          const hiveName = 'testHive';

          await container.read(hiveDataProvider.notifier).addHive(
              hiveName: hiveName);
          expect(container
              .read(hiveDataProvider.notifier)
              .state
              .first
              .hiveName, hiveName);
      });
  });

    test('updateHivePhoto should update the photo', () async {
      final container = ProviderContainer();
      final mockPhoto = MockFile();
      const hiveName = 'testHive';
      container
          .read(hiveDataProvider.notifier)
          .state = [Hive(hiveName: hiveName)];

      container.read(hiveDataProvider.notifier).updateHivePhoto(
          hiveName, mockPhoto);
      expect(container
          .read(hiveDataProvider.notifier)
          .state
          .first
          .photo, mockPhoto);
    });
    test('deleteHive should remove hive from the state', () async {
      final container = ProviderContainer();
      final mockPhoto = MockFile();
      const hiveName = 'testHive';
      const hiveName1 = 'testHive1';
      const hiveId = 'a';
      const hiveId1 = 'b';

      container
          .read(hiveDataProvider.notifier)
          .state = [
        Hive(hiveName: hiveName, photo: mockPhoto, hiveId: hiveId),
        Hive(hiveName: hiveName1, hiveId: hiveId1)
      ];

      container.read(hiveDataProvider.notifier).deleteHive(hiveId);
      expect(container.read(hiveDataProvider.notifier).state.length, 1);
      expect(container.read(hiveDataProvider.notifier).state.first.hiveId, hiveId1);
    });

}