import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:pszczoly_v3/main.dart';
import 'package:pszczoly_v3/screens/add_hive_screen.dart';
import 'package:pszczoly_v3/widgets/sunset_widget.dart';

void main() async {

  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();
  testWidgets('Smoke test', (WidgetTester tester) async {
    final container = ProviderContainer();
    await tester.pumpWidget(ProviderScope(
        parent: container, child: const MyApp()));
    await tester.pumpAndSettle(const Duration(seconds: 10));
    expect(find.byType(AppBar), findsOneWidget);
    expect(find.byType(SunsetWidget), findsOneWidget);
    expect(find.byKey(const ValueKey('languageMenu')), findsOneWidget);
  });

  testWidgets('Adding the hive', (WidgetTester tester) async {
    final container = ProviderContainer();
    await tester.pumpWidget(ProviderScope(
        parent: container, child: const MyApp()));
    await tester.pumpAndSettle(const Duration(seconds: 10));

    final addHiveButtonFinder = find.byKey(const Key('mainAddHiveButton'));  // Replace with the actual key you assigned

    await tester.tap(addHiveButtonFinder);
    await tester.pump( );

    expect(find.byType(AddHiveScreen), findsOneWidget);

    final textFieldFinder = find.byType(TextField);
    await tester.enterText(textFieldFinder, 'New Hive Name');
    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pumpAndSettle();

    final fabFinder = find.byType(FloatingActionButton);
    await tester.tap(fabFinder);
    await tester.pumpAndSettle();

    expect(find.byType(AddHiveScreen), findsNothing);
    expect(find.text('New Hive Name'), findsOneWidget);
  });
}

