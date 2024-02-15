import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:pszczoly_v3/screens/hives_list_screen.dart';
import '../providers/hive_list_provider.dart';

class StartingScreen extends ConsumerStatefulWidget {
  const StartingScreen({super.key});

  @override
  ConsumerState<StartingScreen> createState() => _StartingScreenState();
}

class _StartingScreenState extends ConsumerState<StartingScreen> {
  // ignore: unused_field
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer(
      const Duration(seconds: 5),
      () {
        if (mounted) {
          final hiveData =
              ref.read(hiveDataProvider); // Read the data before navigation
          Navigator.pushReplacement(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) =>
                  HivesListScreen(hives: hiveData),
            ),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      Center(
        child: SizedBox(
          width: 250.0,
          child: DefaultTextStyle(
            style: TextStyle(
              fontSize: 80.0,
              fontFamily: GoogleFonts.zeyada().fontFamily,
              color: Colors.black,
            ),
            child: AnimatedTextKit(
              totalRepeatCount: 1,
              animatedTexts: [
                TypewriterAnimatedText('ULala', speed: Durations.long2),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Hero(
//               tag: 'logoTag',
//               child: Padding(
//                 padding: const EdgeInsets.all(20),
//                 child: Image.asset(
//                   'assets/images/logo.png',
//                   width: 200,
//                   height: 200,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
