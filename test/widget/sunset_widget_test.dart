import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:pszczoly_v3/models/sunset_sunrise.dart';
import 'package:pszczoly_v3/providers/sunset_sunrise_provider.dart';
import 'package:pszczoly_v3/widgets/sunset_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MockSunsetSunriseNotifierError extends Mock implements SunsetSunriseNotifier {
  @override
  Future<SunsetSunrise?> fetchData() async {
    throw Exception('Simulated error');
  }
}

class MockSunsetSunriseNotifierNoData extends Mock implements SunsetSunriseNotifier {
  @override
  Future<SunsetSunrise?> fetchData() async {
   return null;
  }
}

void main() {
  testWidgets('SunsetWidget renders correctly', (WidgetTester tester) async {
    await tester.pumpWidget(const ProviderScope(child: SunsetWidget()));
    expect(find.byType(SunsetWidget), findsOneWidget);
  });

  testWidgets('SunsetWidget shows loading indicator',
      (WidgetTester tester) async {
    await tester.pumpWidget(const ProviderScope(child: SunsetWidget()));
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('SunsetWidget shows error message', (WidgetTester tester) async {
    final mockNotifier = MockSunsetSunriseNotifierError();

    await tester.pumpWidget(ProviderScope(
        overrides: [sunsetSunriseProvider.overrideWith((ref) => mockNotifier)],
        child: Localizations(
            locale: const Locale('pl'),
            delegates: AppLocalizations.localizationsDelegates,
            child: const SunsetWidget())));
    await tester.pumpAndSettle();

    try {
      await tester.pumpAndSettle();
    } catch (e) {
      expect(e, isInstanceOf<Exception>());
      expect(e.toString(), 'Simulated error');
      expect(find.text('Błąd Simulated error'), findsOneWidget);
    }
  });

  testWidgets('SunsetWidget shows no data message', (WidgetTester tester) async {
    final mockNotifier = MockSunsetSunriseNotifierNoData();

    await tester.pumpWidget(ProviderScope(
        overrides: [sunsetSunriseProvider.overrideWith((ref) => mockNotifier)],
        child: Localizations(
            locale: const Locale('pl'),
            delegates: AppLocalizations.localizationsDelegates,
            child: const SunsetWidget())));
    await tester.pumpAndSettle();

      expect(find.text('Brak danych'), findsOneWidget);
  });
}
