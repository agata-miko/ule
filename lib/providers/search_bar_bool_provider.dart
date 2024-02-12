import 'package:flutter_riverpod/flutter_riverpod.dart';

final searchBarVisibilityProvider =
    StateNotifierProvider<searchBarVisibilityNotifier, bool>((ref) {
  return searchBarVisibilityNotifier();
});

class searchBarVisibilityNotifier extends StateNotifier<bool> {
  searchBarVisibilityNotifier() : super(false);

  void toggleSearchBool() {
    state = !state;
    print('SearchBool toggled: $state');
  }
}
