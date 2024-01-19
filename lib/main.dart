import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pszczoly_v3/screens/starting_screen.dart';
import 'package:pszczoly_v3/screens/welcome_screen.dart';
import 'package:pszczoly_v3/services/database_helper.dart';
import '../theme/app_theme_2.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseHelper.initializeDatabase();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: lightTheme,
        home: const StartingScreen(),
    );
  }
}
