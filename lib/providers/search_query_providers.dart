import 'package:flutter_riverpod/flutter_riverpod.dart';


final hivesSearchQueryProvider = StateNotifierProvider<HivesSearchQueryNotifier, String>((ref) {
  return HivesSearchQueryNotifier();
});

class HivesSearchQueryNotifier extends StateNotifier<String> {
  HivesSearchQueryNotifier() : super('');

  void updateSearchQuery(String query) {
    state = query;
  }
}
