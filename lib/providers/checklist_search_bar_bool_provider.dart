import 'package:flutter_riverpod/flutter_riverpod.dart';

final searchBarVisibilityProviderChecklists =
StateNotifierProvider<SearchBarVisibilityNotifierChecklists, bool>((ref) {
  return SearchBarVisibilityNotifierChecklists();
});

class SearchBarVisibilityNotifierChecklists extends StateNotifier<bool> {
  SearchBarVisibilityNotifierChecklists() : super(false);

  void toggleSearchBool() {
    state = !state;
  }
}