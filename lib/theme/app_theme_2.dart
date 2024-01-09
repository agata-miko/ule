import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  useMaterial3: true,
  textTheme: const TextTheme(
    displayLarge: TextStyle(fontSize: 32),
    bodyLarge: TextStyle(fontSize: 18),
    bodyMedium: TextStyle(fontSize: 16),
    bodySmall: TextStyle(fontSize: 10),
  ).apply(fontFamily: GoogleFonts.bungeeSpice().fontFamily),
  appBarTheme: AppBarTheme(titleTextStyle: TextStyle(fontFamily: GoogleFonts.bungeeSpice().fontFamily, fontSize: 32),
    color: const Color(0xFFd5bdaf),
    iconTheme: const IconThemeData(color: Colors.black54),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all(const Color(0xFFe3d5ca)),
      foregroundColor: MaterialStateProperty.all(Colors.black54),
    ),
  ),
  colorScheme: const ColorScheme(
    primaryContainer: Color.fromRGBO(255, 255, 255, 1),
    secondaryContainer: Colors.white,
    background: Color.fromRGBO(255, 255, 255, 1),
    primary: Color(0xFFd5bdaf),
    secondary: Color(0xFFd5bdaf),
    brightness: Brightness.light,
    error: Colors.red,
    onBackground: Colors.black54,
    onError: Colors.white,
    onPrimary: Colors.black54,
    onSecondary: Colors.black54,
    onSurface: Colors.black54,
    surface: Color(0xFFedede9),
  ),
);
