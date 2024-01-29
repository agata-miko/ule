import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String languageCode = 'languageCode';

const String english = 'en';
const String polish = 'pl';

Future<Locale?> setLocale(String languageCode) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString(languageCode, languageCode);
  return _locale(languageCode);
}

Future<Locale?> getLocale() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String langCode = prefs.getString(languageCode) ?? polish;
  return _locale(langCode);
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

// AppLocalizations translation(BuildContext context) {
//   return AppLocalizations.of(context)!;
// }