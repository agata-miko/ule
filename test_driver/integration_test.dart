import 'dart:convert';
import 'dart:io';

import 'package:integration_test/integration_test_driver.dart';

Future<void> main() async {
  await Process.run(
    'adb',
    [
      'shell',
      'pm',
      'grant',
      'com.example.pszczoly_v3', // TODO: Update this
      'android.permission.ACCESS_FINE_LOCATION'
    ],
  );
  // TODO: Add more permissions as required
  await integrationDriver();
}