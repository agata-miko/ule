import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pszczoly_v3/screens/add_hive_screen.dart';
import 'package:pszczoly_v3/screens/hives_list_screen.dart';
import 'package:pszczoly_v3/screens/welcome_screen.dart';
import '../theme/app_theme.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: customTheme,
        darkTheme: darkCustomTheme,
        home: const WelcomeScreen(),
    );
  }
}
