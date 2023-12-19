import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pszczoly_v3/models/hive.dart';
import 'package:pszczoly_v3/screens/add_hive_screen.dart';
import 'package:pszczoly_v3/widgets/hives_list.dart';

class HivesListScreen extends ConsumerWidget {
  const HivesListScreen({super.key, required this.hives});

  final List<Hive> hives;

  @override
  Widget build(BuildContext context, ref) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista uli'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (ctx) => const AddHiveScreen(),
                  ),
                );
              },
              child: const Text('Dodaj nowy ul'),
            ),
            const SizedBox(
              height: 10,
            ),
            const SizedBox(height: 400, child: HivesList()),
          ],
        ),
      ),
    );
  }
}
