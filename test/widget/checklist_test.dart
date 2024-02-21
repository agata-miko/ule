import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:mockito/mockito.dart';
import 'package:pszczoly_v3/data/checklist_questions_data.dart';
import 'package:pszczoly_v3/widgets/checklist.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  testWidgets('Initial state test', (WidgetTester tester) async {

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Localizations(
                locale: const Locale('en'),
                delegates: AppLocalizations.localizationsDelegates,
                child: Checklist(
                  hiveId: 1,
                  checklistDate: DateTime.now(),
                  checklistId: 1,
                )),
        ),
        ),
    );
    await tester.pumpAndSettle();
    await tester.pump();

    expect(find.byType(Checklist), findsOneWidget);
  });

  testWidgets('Answering questions updates UI', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Localizations(
            locale: const Locale('pl'),
            delegates: AppLocalizations.localizationsDelegates,
            child: Checklist(
              hiveId: 1,
              checklistDate: DateTime.now(),
              checklistId: 1,
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    final ChecklistState state = tester.state(find.byType(Checklist));

    await tester.tap(find.byKey(const Key('q1_yes')));
    expect(find.byKey(const Key('q1_yes')), findsOneWidget);
    expect(state.questionAnswersMap['q1']?.answer, true);

    await tester.drag(find.byType(ListView), const Offset(0, -800));
    await tester.pump();
    await tester.tap(find.byKey(const Key('q11_text')));
    await tester.pump();
    await tester.enterText(find.byKey(const Key('q11_text')), 'Test answer');
    await tester.pump();
    expect(find.byKey(const Key('q11_text')), findsOneWidget);
    expect(state.questionAnswersMap['q11']?.answer, 'Test answer');
  });
}
