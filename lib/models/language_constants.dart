import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

const String languageCodeKey = 'languageCode';

const String english = 'en';
const String polish = 'pl';

Future<Locale?> setLocale(String languageCode) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString(languageCodeKey, languageCode);
  return _locale(languageCode);
}

Future<Locale?> getLocale() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String languageCode = prefs.getString(languageCodeKey) ?? polish;
  return _locale(languageCode);
}

Locale? _locale(String langCode) {
  switch (langCode) {
    case english:
      return const Locale('en');
    case polish:
      return const Locale('pl');
  }
  return null;
}

AppLocalizations translation(BuildContext context) {
  return AppLocalizations.of(context)!;
}