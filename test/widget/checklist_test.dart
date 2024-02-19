import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter/material.dart';
import 'package:pszczoly_v3/widgets/checklist.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MockAppLocalizations extends Mock implements AppLocalizations {}

void main() {
  setUp(() {
    final mockLocalizations = MockAppLocalizations();
    when(mockLocalizations.sliderPercentage('50')).thenReturn('50%');});
  testWidgets('Initial state test', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Checklist(hiveId: 1, checklistDate: DateTime.now(),checklistId: 1,),
      ),
    );
    expect(find.byType(Checklist), findsOneWidget);
    // expect(find.text('50%'), findsOneWidget);
  });
}