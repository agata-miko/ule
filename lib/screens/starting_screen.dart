import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pszczoly_v3/screens/hives_list_screen.dart';
import '../providers/hive_list_provider.dart';

class StartingScreen extends ConsumerStatefulWidget {
  const StartingScreen({super.key});

  @override
  ConsumerState<StartingScreen> createState() => _StartingScreenState();
}

class _StartingScreenState extends ConsumerState<StartingScreen> {
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer(
      const Duration(seconds: 2),
      () {
        if (mounted) {
          final hiveData =
              ref.read(hiveDataProvider); // Read the data before navigation
          Navigator.pushReplacement(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) =>
                  HivesListScreen(hives: hiveData),
              transitionDuration: const Duration(microseconds: 180),
            ),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Hero(
              tag: 'logoTag',
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Image.asset(
                  'assets/images/logo.png',
                  width: 200,
                  height: 200,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
