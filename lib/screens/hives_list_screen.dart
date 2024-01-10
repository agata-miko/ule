import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pszczoly_v3/models/hive.dart';
import 'package:pszczoly_v3/screens/add_hive_screen.dart';
import 'package:pszczoly_v3/widgets/hives_list.dart';

class HivesListScreen extends ConsumerWidget {
  HivesListScreen({super.key, required this.hives});

  final List<Hive> hives;
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context, ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista uli'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const SizedBox(height: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: SizedBox(
                      width: double.infinity,
                      child: TextField(
                        controller: _searchController,
                        decoration: InputDecoration(
                            hintText: 'Znajdź ul...',
                            hintStyle: Theme.of(context).textTheme.bodyMedium,
                            suffixIcon: IconButton(
                              icon: const Icon(Icons.clear),
                              onPressed: () => _searchController.clear(),
                            ),
                            prefixIcon: IconButton(
                              icon: const Icon(Icons.search),
                              onPressed: () {}, // tutaj wyszukiwanie
                            ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20))),
                      )),
                ),
                const SizedBox(height: 20,),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (ctx) => const AddHiveScreen(),
                        ),
                      );
                    },
                    child: Container(
                      width: 150,
                      child: Row(
                        children: [
                          Text('Dodaj nowy ul',
                              style: Theme.of(context).textTheme.bodyMedium),
                          Icon(Icons.add_home),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            const SizedBox(height: 320, child: HivesList()),
          ],
        ),
      ),
    );
  }
}
