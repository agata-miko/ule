import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pszczoly_v3/providers/database_provider.dart';
import 'package:pszczoly_v3/services/database_helper.dart';
import 'package:test/test.dart';

void main() {
  test('databaseProvider returns an instance of DatabaseHelper', () {
    final container = ProviderContainer();

    expect(container.read(databaseProvider), isA<DatabaseHelper>());
  });

  test('databaseProvider returns the same instance', () {
    final container = ProviderContainer();

    final dbInstance1 = container.read(databaseProvider);
    final dbInstance2 = container.read(databaseProvider);

    expect(dbInstance1, equals(dbInstance2));
  });
}
