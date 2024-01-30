import 'package:flutter_riverpod/flutter_riverpod.dart';

final selectedDateProvider =
StateNotifierProvider<SelectedDateNotifier, DateTime?>(
        (ref) => SelectedDateNotifier());

class SelectedDateNotifier extends StateNotifier<DateTime?> {
  SelectedDateNotifier() : super(null);

  void setSelectedDate(DateTime? date) {
    state = date;
  }
}
