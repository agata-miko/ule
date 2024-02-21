import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:pszczoly_v3/widgets/percentage_slider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  testWidgets('Initial state test', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(home: Scaffold(
        body: Localizations(
          locale: const Locale('pl'),
          delegates: AppLocalizations.localizationsDelegates,
          child: const PercentageSlider(selectedPercentage: 50),
        ),
      ),),
    );
    expect(find.byType(PercentageSlider), findsOneWidget);
    expect(find.text('50%'), findsOneWidget);
  });

  testWidgets('Slider updates value and triggers callback', (WidgetTester tester) async {
    double selectedPercentage = 50;
    double percentageChange = 1.0;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Localizations(
            locale: const Locale('pl'),
            delegates: AppLocalizations.localizationsDelegates,
            child: PercentageSlider(selectedPercentage: selectedPercentage),
          ),
        ),
      ),
    );

    double sliderWidth = MediaQuery.of(tester.element(find.byType(Slider))).size.width;
    double offset = (sliderWidth / 100) * percentageChange;


    expect(find.text('${selectedPercentage.round()}%'), findsOneWidget);

    await tester.drag(find.byType(Slider), Offset(offset, 0.0));
    await tester.pump();

    expect(find.text('${selectedPercentage.round()}%'), findsNothing);  // Old value should not be present
    expect(find.text('${selectedPercentage.round() + 1}%'), findsOneWidget);  // New value should be present
  });

}
