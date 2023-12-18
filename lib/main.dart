import 'package:flutter/material.dart';
import 'package:pszczoly_v3/screens/checklist_screen.dart';
import 'screens/welcome_screen.dart';
import '../theme/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: customTheme, 
        darkTheme: darkCustomTheme,
        home: const ChecklistScreen()
    );
  }
}