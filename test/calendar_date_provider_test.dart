import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pszczoly_v3/providers/calendar_date_provider.dart';

void main () {
  test('SelectedDateNotifier should update state with selectedDate', () {
    final container = ProviderContainer();

    final selectedDate = container.read(selectedDateProvider.notifier);

    final testDateTime = DateTime(2024, 1, 31);

    selectedDate.setSelectedDate(testDateTime);

    expect(container.read(selectedDateProvider), equals(testDateTime));
  });

  test('SelectedDateNotifier should update state with selectedDate multiple times', () {
    final container = ProviderContainer();

    final selectedDate = container.read(selectedDateProvider.notifier);

    final testDateTimeList = [
      DateTime(2024, 1, 31),
      DateTime(2024, 2, 29),
      DateTime(2024, 3, 31),
      DateTime(2024, 4, 30),
      DateTime(2024, 5, 31),
    ];

    for (final testDateTime in testDateTimeList) {
      selectedDate.setSelectedDate(testDateTime);
      final readResult = container.read(selectedDateProvider);
      expect(readResult, equals(testDateTime));
    }

    expect(container.read(selectedDateProvider), equals(testDateTimeList.last));
  });

  test('SelectedDateNotifier default state should be null', () {
    final container = ProviderContainer();

    expect(container.read(selectedDateProvider), isNull);
  });

  test('SelectedDateNotifier should handle null selectedDate', () {
    final container = ProviderContainer();

    final selectedDate = container.read(selectedDateProvider.notifier);

    selectedDate.setSelectedDate(null);

    expect(container.read(selectedDateProvider), isNull);
  });

  test('SelectedDateNotifier should have initial state of null', () {
    final container = ProviderContainer();
    expect(container.read(selectedDateProvider), isNull);
  });

  test('SelectedDateNotifier should handle setting to null when already null', () {
    final container = ProviderContainer();
    final selectedDate = container.read(selectedDateProvider.notifier);

    selectedDate.setSelectedDate(null);
    expect(container.read(selectedDateProvider), isNull);

    selectedDate.setSelectedDate(null);
    expect(container.read(selectedDateProvider), isNull);
  });

  test('SelectedDateNotifier should handle different instances of the same date', () {
    final container = ProviderContainer();
    final selectedDate = container.read(selectedDateProvider.notifier);

    final testDateTime1 = DateTime(2024, 1, 31);
    final testDateTime2 = DateTime(2024, 1, 31);

    selectedDate.setSelectedDate(testDateTime1);
    expect(container.read(selectedDateProvider), equals(testDateTime1));

    selectedDate.setSelectedDate(testDateTime2);
    expect(container.read(selectedDateProvider), equals(testDateTime2));
  });

  test('SelectedDateNotifier should handle future dates', () {
    final container = ProviderContainer();
    final selectedDate = container.read(selectedDateProvider.notifier);

    final testDateTime = DateTime.now().add(const Duration(days: 7));

    selectedDate.setSelectedDate(testDateTime);
    expect(container.read(selectedDateProvider), equals(testDateTime));
  });

  test('SelectedDateNotifier should handle different timezones', () {
    final container = ProviderContainer();
    final selectedDate = container.read(selectedDateProvider.notifier);

    final testDateTimeUTC = DateTime.utc(2024, 1, 31);
    final testDateTimeLocal = testDateTimeUTC.toLocal();

    selectedDate.setSelectedDate(testDateTimeUTC);
    expect(container.read(selectedDateProvider), equals(testDateTimeUTC));

    selectedDate.setSelectedDate(testDateTimeLocal);
    expect(container.read(selectedDateProvider), equals(testDateTimeLocal));
  });

}