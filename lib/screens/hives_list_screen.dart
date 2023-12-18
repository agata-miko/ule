import 'package:flutter/material.dart';
import 'package:pszczoly_v3/screens/add_hive_screen.dart';
import 'package:pszczoly_v3/widgets/hives_list.dart';

class HivesListScreen extends StatelessWidget {
  const HivesListScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
              child: Text('Dodaj nowy ul'),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(height: 400, child: const HivesList(hives: [])),
          ],
        ),
      ),
    );
  }
}