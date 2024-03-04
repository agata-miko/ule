import 'dart:io';

import 'package:integration_test/integration_test_driver.dart';

Future<void> main() async {
  await Process.run(
    'adb',
    [
      'shell',
      'pm',
      'grant',
      'com.example.pszczoly_v3',
      'android.permission.ACCESS_FINE_LOCATION'
    ],
  );
  await integrationDriver();
}