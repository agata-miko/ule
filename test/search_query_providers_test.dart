import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pszczoly_v3/providers/search_query_providers.dart';

void main () {
  group('hivesSearchQueryProvider tests', () {
    test('provider should update the state', () {
      final container = ProviderContainer();
      const mockQuery = 'mock1';
      final query = container.read(hivesSearchQueryProvider.notifier);

      query.updateSearchQuery(mockQuery);
      expect(container.read(hivesSearchQueryProvider), equals(mockQuery));
    });

    test('provider should update the state multiple times', () {
      final container = ProviderContainer();
      final query = container.read(hivesSearchQueryProvider.notifier);

      List<String> mockQueriesList = [
        'mock1', 'mock2', 'mock3', 'mock4'
      ];

      for(String mockQ in mockQueriesList) {
        query.updateSearchQuery(mockQ);
        expect(container.read(hivesSearchQueryProvider), equals(mockQ));
      }
      expect(container.read(hivesSearchQueryProvider), equals(mockQueriesList.last));
    });

    test('default state should be empty', () {
      final container = ProviderContainer();
      expect(container.read(hivesSearchQueryProvider), isEmpty);
    });

    test('provider should handle empty query', () {
      final container = ProviderContainer();
      final query = container.read(hivesSearchQueryProvider.notifier);

      query.updateSearchQuery('');
      expect(container.read(hivesSearchQueryProvider), isEmpty);
    });

  });

  group('checklistSearchQueryProvider tests', () {
    test('provider should update the state', () {
      final container = ProviderContainer();
      const mockQuery = 'mock1';
      final query = container.read(checklistSearchQueryProvider.notifier);

      query.updateSearchQuery(mockQuery);
      expect(container.read(checklistSearchQueryProvider), equals(mockQuery));
    });
    test('provider should update the state multiple times', () {
      final container = ProviderContainer();
      final query = container.read(checklistSearchQueryProvider.notifier);

      List<String> mockQueriesList = [
        'mock1', 'mock2', 'mock3', 'mock4'
      ];

      for(String mockQ in mockQueriesList) {
        query.updateSearchQuery(mockQ);
        expect(container.read(checklistSearchQueryProvider), equals(mockQ));
      }
      expect(container.read(checklistSearchQueryProvider), equals(mockQueriesList.last));
    });

    test('default state should be empty', () {
      final container = ProviderContainer();
      expect(container.read(checklistSearchQueryProvider), equals(''));
    });

    test('provider should handle empty query', () {
      final container = ProviderContainer();
      final query = container.read(checklistSearchQueryProvider.notifier);

      query.updateSearchQuery('');
      expect(container.read(checklistSearchQueryProvider), isEmpty);
    });
  });
}