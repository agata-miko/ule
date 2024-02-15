import 'package:flutter_riverpod/flutter_riverpod.dart';

final searchBarVisibilityProvider =
    StateNotifierProvider<SearchBarVisibilityNotifier, bool>((ref) {
  return SearchBarVisibilityNotifier();
});

class SearchBarVisibilityNotifier extends StateNotifier<bool> {
  SearchBarVisibilityNotifier() : super(false);

  void toggleSearchBool() {
    state = !state;
  }
}