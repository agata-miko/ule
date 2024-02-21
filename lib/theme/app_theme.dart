import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  useMaterial3: true,
  textTheme: const TextTheme(
    displayLarge: TextStyle(fontSize: 32, color: Color(0xFF1B2805)),
    bodyLarge: TextStyle(fontSize: 24, color: Color(0xFF1B2805)),
    bodyMedium: TextStyle(fontSize: 16, color: Color(0xFF1B2805)),
    bodySmall: TextStyle(fontSize: 8, color: Color(0xFF1B2805)),
  ).apply(
    fontFamily: GoogleFonts.karla().fontFamily,
  ),
  appBarTheme: AppBarTheme(
    titleTextStyle: TextStyle(
      fontFamily: GoogleFonts.montserrat().fontFamily,
      fontWeight: FontWeight.w900,
      fontSize: 20,
      color: const Color(0xFF1B2805),
    ),
    color: Colors.transparent,
    elevation: 0.0,
    scrolledUnderElevation: 0.0,
    iconTheme: const IconThemeData(color: Color(0xFF1B2805)),
    centerTitle: true,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      textStyle: MaterialStatePropertyAll(TextStyle(
          fontSize: 16,
          fontFamily:
              GoogleFonts.karla().fontFamily)),
      backgroundColor: MaterialStateProperty.all(const Color(0xFF233406)),//(const Color(0xFFE6CEBA)),
      foregroundColor: MaterialStateProperty.all(Colors.white),//(const Color(0xFF1B2805)),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(splashFactory: NoSplash.splashFactory,
        textStyle: MaterialStatePropertyAll(
      TextStyle(fontFamily: GoogleFonts.karla().fontFamily, fontSize: 16, color: const Color(0xFF1B2805)),
    )),
  ),
  iconTheme: const IconThemeData(
      color: Color(0xFF1B2805),
  ),
  popupMenuTheme: PopupMenuThemeData(
    color: Colors.white,
    textStyle: TextStyle(
      fontFamily: GoogleFonts.roboto(fontWeight: FontWeight.w300).fontFamily,
      fontSize: 12,
      color:const Color(0xFF1B2805),
    ),
  ),
  datePickerTheme: const DatePickerThemeData(
    backgroundColor: Colors.white,
    elevation: 0,
  ),

  colorScheme: const ColorScheme(
    primaryContainer: Color(0xFFFCF9F1),
    secondaryContainer: Color(0xFFFCF9F1),
    background: Color(0xFFFCF9F1),
    primary: Colors.black26,
    secondary: Colors.black54,
    brightness: Brightness.light,
    error: Colors.red,
    onBackground: Colors.black54,
    onError: Colors.white,
    onPrimary: Colors.black54,
    onSecondary: Colors.black54,
    onSurface: Colors.black54,
    surface: Colors.black12,
  ),
);
