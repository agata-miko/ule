import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';
import 'package:mockito/mockito.dart';
import 'package:pszczoly_v3/services/database_helper.dart';
import 'package:pszczoly_v3/widgets/checklists_list.dart';
import 'package:pszczoly_v3/providers/database_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MockDatabaseProviderNoData extends Mock implements DatabaseHelper {
  @override
  Future<List<Map<String, dynamic>>> getChecklistsForAHive(int hiveId) async {
    return Future.value(<Map<String, dynamic>>[]);
  }
}

class MockDatabaseProviderWithData extends Mock implements DatabaseHelper {
  @override
  Future<List<Map<String, dynamic>>> getChecklistsForAHive(int hiveId) async {
    return Future.value(<Map<String, dynamic>>[
      {
        'checklistId': 1,
        'hiveId': 1,
        'checklistDate': DateTime.now().millisecondsSinceEpoch.toString(),
      },
      {
        'checklistId': 2,
        'hiveId': 2,
        'checklistDate': DateTime.now()
            .subtract(const Duration(days: 7))
            .millisecondsSinceEpoch
            .toString(),
      }
    ]);
  }

  @override
  Future<int> deleteChecklist(int filledChecklistId) async {
    return Future.value(1);
  }
}

main() {
  testWidgets('ListOfChecklists displays loading indicator',
      (WidgetTester tester) async {
    await tester.pumpWidget(const ProviderScope(
        child: ListOfChecklists(hiveId: 1, hiveName: 'Hive Name')));
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('ListOfChecklists displays empty state',
      (WidgetTester tester) async {
    final mockNotifier = MockDatabaseProviderNoData();
    await tester.pumpWidget(ProviderScope(
        overrides: [databaseProvider.overrideWith((ref) => mockNotifier)],
        child: Localizations(
            locale: const Locale('pl'),
            delegates: AppLocalizations.localizationsDelegates,
            child: const ListOfChecklists(hiveId: 1, hiveName: 'Hive Name'))));

    await tester.pumpAndSettle();

    expect(find.text('Brak checklist dla tego ula'), findsOneWidget);
  });

  testWidgets('ListOfChecklists displays checklists',
      (WidgetTester tester) async {
    final container = ProviderContainer();
    final mockNotifier = MockDatabaseProviderWithData();
    await tester.pumpWidget(ProviderScope(
        parent: container,
        overrides: [databaseProvider.overrideWith((ref) => mockNotifier)],
        child: Localizations(
            locale: const Locale('pl'),
            delegates: AppLocalizations.localizationsDelegates,
            child: const ListOfChecklists(hiveId: 1, hiveName: 'Hive Name'))));

    await tester.pumpAndSettle();

    expect(find.byType(Dismissible), findsNWidgets(2));
    expect(
        find.text(
            DateFormat('dd/MM/yyyy').format(DateTime.now()).toLowerCase()),
        findsOneWidget);
    expect(
        find.text(DateFormat('dd/MM/yyyy')
            .format(DateTime.now().subtract(const Duration(days: 7)))
            .toLowerCase()),
        findsOneWidget);
  });

  testWidgets('ListOfChecklists allows dismissal', (WidgetTester tester) async {
    final mockNotifier = MockDatabaseProviderWithData();
    final container = ProviderContainer();
    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        locale: const Locale('pl'),
        home: ProviderScope(
            parent: container,
            overrides: [databaseProvider.overrideWith((ref) => mockNotifier)],
            child: const ListOfChecklists(hiveId: 1, hiveName: 'Hive Name')),
      ),
    );

    await tester.pumpAndSettle();
    expect(find.byType(Dismissible), findsNWidgets(2));

    await tester.drag(find.byType(Dismissible).first, const Offset(-600.0, 0.0));
    await tester.pumpAndSettle();

    expect(find.byType(AlertDialog), findsOneWidget);

    final removeButton = find.widgetWithText(TextButton, 'Usuń');
    await tester.pumpAndSettle();
    await tester.tap(removeButton);
    // verify(mockNotifier.deleteChecklist(1)).called(1);
    await tester.pumpAndSettle();

    expect(find.byType(Dismissible), findsOneWidget);
  });
}
