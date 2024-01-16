import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pszczoly_v3/providers/hive_list_provider.dart';
import 'package:pszczoly_v3/screens/hives_list_screen.dart';

class WelcomeScreen extends ConsumerWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Opacity(
            opacity: 0.8,
            child: Image.asset(
              'assets/images/background1.png',
              // Replace with your image file path
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 300,
                  ),
                  // const SizedBox(height: 20),
                  // Padding(
                  //   padding: EdgeInsets.symmetric(horizontal: 30),
                  //   child: TextField(
                  //     decoration: InputDecoration(
                  //       filled: true,
                  //       fillColor: Theme.of(context).colorScheme.primaryContainer.withOpacity(0.8),
                  //       hintText: 'Username',
                  //       enabledBorder: OutlineInputBorder(
                  //         borderSide: BorderSide(width: 0.2),
                  //       ),
                  //       focusedBorder: OutlineInputBorder(
                  //         borderSide: BorderSide(width: 0.2),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  // const SizedBox(height: 10),
                  // Padding(
                  //   padding: EdgeInsets.symmetric(horizontal: 30),
                  //   child: TextField(
                  //     obscureText: true,
                  //     decoration: InputDecoration(
                  //       filled: true,
                  //       fillColor: Theme.of(context).colorScheme.primaryContainer.withOpacity(0.8),
                  //       hintText: 'Password',
                  //       enabledBorder: OutlineInputBorder(
                  //         borderSide: BorderSide(width: 0.2),
                  //       ),
                  //       focusedBorder: OutlineInputBorder(
                  //           borderSide: BorderSide(width: 0.2)),
                  //     ),
                  //   ),
                  // ),
                  SizedBox(
                    child: Text(
                      'Dzień dobry!\nGotów na przegląd swojej pasieki?\nZaczynajmy!',
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: Colors.pink,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  FloatingActionButton.extended(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (ctx) => HivesListScreen(
                              hives: ref.watch(hiveDataProvider))));
                    },
                    backgroundColor: Theme.of(context).colorScheme.secondary,
                    label: const Text('Zaczynajmy'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
