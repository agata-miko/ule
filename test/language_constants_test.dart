import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pszczoly_v3/models/language_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  test('setLocale should return the Locale object with "en" code', () async {
    SharedPreferences.setMockInitialValues({});

    Locale? locale = await setLocale('en');
    expect(locale, const Locale('en'));
  });

  test('setLocale should return the Locale object with "pl" code', () async {
    SharedPreferences.setMockInitialValues({});

    Locale? locale = await setLocale('pl');
    expect(locale, const Locale('pl'));
  });

  test(
      'setLocale should return null when given improper language code', () async {
    SharedPreferences.setMockInitialValues({});

    Locale? locale = await setLocale('fr');
    expect(locale, null);
  });

  test('setLocale should store language code in shared preferences', () async {
    SharedPreferences.setMockInitialValues({});

    await setLocale('en');

    SharedPreferences prefs = await SharedPreferences.getInstance();
    expect(prefs.getString(languageCodeKey), 'en');
  });

  test('setLocale should store language code in shared preferences', () async {
    SharedPreferences.setMockInitialValues({});

    await setLocale('pl');

    SharedPreferences prefs = await SharedPreferences.getInstance();
    expect(prefs.getString(languageCodeKey), 'pl');
  });

  test('getLocale should return Locale object with "en" language code', () async{
    SharedPreferences.setMockInitialValues({languageCodeKey: 'en'});

    Locale? locale = await getLocale();

    expect(locale!.languageCode, 'en');
  });

  test('getLocale should return Locale object with "pl" language code', () async{
    SharedPreferences.setMockInitialValues({languageCodeKey: 'pl'});

    Locale? locale = await getLocale();

    expect(locale!.languageCode, 'pl');
  });

  test('''getLocale should return default language code when no language code 
  is saved in shared preferences''', () async {
    SharedPreferences.setMockInitialValues({});

    Locale? locale = await getLocale();

    expect(locale!.languageCode, 'pl');
  });

  test('getLocale should return null if the unsupported language code is saved in shared preferences', () async {
    SharedPreferences.setMockInitialValues({languageCodeKey: 'fr'});

    Locale? locale = await getLocale();

    expect(locale, null);
  });
}
