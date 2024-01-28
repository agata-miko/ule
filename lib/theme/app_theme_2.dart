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
  ).apply(
      fontFamily: GoogleFonts.roboto(fontWeight: FontWeight.w300).fontFamily),
  appBarTheme: AppBarTheme(
    titleTextStyle: TextStyle(
      fontFamily: GoogleFonts.roboto(fontWeight: FontWeight.w300).fontFamily,
      fontSize: 20,
      color: Colors.black54,
    ),
    color: Colors.transparent,
    iconTheme: const IconThemeData(color: Colors.black54),
    centerTitle: true,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      textStyle: MaterialStatePropertyAll(TextStyle(
          fontSize: 14,
          fontFamily:
              GoogleFonts.roboto(fontWeight: FontWeight.w300).fontFamily)),
      backgroundColor: MaterialStateProperty.all(Colors.white),
      foregroundColor: MaterialStateProperty.all(Colors.black54),
    ),
  ),
  textButtonTheme: const TextButtonThemeData(
      style: ButtonStyle(
          foregroundColor: MaterialStatePropertyAll(Colors.black54))),
  iconTheme: const IconThemeData(
    color: Colors.black54,
  ),

  popupMenuTheme: PopupMenuThemeData(
    color: Colors.white,
    textStyle: TextStyle(
      fontFamily: GoogleFonts.roboto(fontWeight: FontWeight.w300).fontFamily,
      fontSize: 12,
      color: Colors.black54,
    ),
  ),


  colorScheme: const ColorScheme(
    primaryContainer: Colors.white,
    secondaryContainer: Colors.white,
    background: Colors.white,
    primary: Colors.black54,
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
