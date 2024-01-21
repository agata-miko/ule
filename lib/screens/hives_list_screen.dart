import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pszczoly_v3/models/hive.dart';
import 'package:pszczoly_v3/screens/add_hive_screen.dart';
import 'package:pszczoly_v3/widgets/hives_list.dart';
import 'package:pszczoly_v3/providers/search_query_providers.dart';

class HivesListScreen extends ConsumerWidget {
  HivesListScreen({super.key, required this.hives});

  final List<Hive> hives;
  final TextEditingController _searchController = TextEditingController();

  void _showAddHiveModal(BuildContext context) {
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25.0))),
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(25.0)),
          child: Container(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.8,
            ), // Adjust the height as needed
            child: const AddHiveScreen(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context, ref) {
    ref.watch(hivesSearchQueryProvider);
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
          child: Hero(tag: 'logoTag',child: Image.asset('assets/images/logo.png')),
        ),
        title: const Text('Moje ule'),
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
                        onChanged: (query) {
                          ref.read(hivesSearchQueryProvider.notifier).updateSearchQuery(query);
                        },
                        decoration: InputDecoration(
                            hintText: 'Znajdź ul...',
                            hintStyle: Theme.of(context).textTheme.bodyMedium,
                            suffixIcon: IconButton(
                              icon: const Icon(Icons.clear),
                              onPressed: () {
                                _searchController.clear();
                                ref.read(hivesSearchQueryProvider.notifier).updateSearchQuery('');
                              },
                            ),
                            prefixIcon: IconButton(
                              icon: const Icon(Icons.search),
                              onPressed: () {},
                            ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20))),
                      )),
                ),
                const SizedBox(
                  height: 20,
                ),
                // Center(
                //   child: ElevatedButton(
                //     onPressed: () {
                //       Navigator.of(context).push(
                //         MaterialPageRoute(
                //           builder: (ctx) => const AddHiveScreen(),
                //         ),
                //       );
                //     },
                //     child: Container(
                //       width: 150,
                //       child: Row(
                //         children: [
                //           Text('Dodaj nowy ul',
                //               style: Theme.of(context).textTheme.bodyMedium),
                //           Icon(Icons.add_home),
                //         ],
                //       ),
                //     ),
                //   ),
                // ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            const SizedBox(height: 340, child: HivesList()),
            FloatingActionButton(
              onPressed: () {
                _showAddHiveModal(context);
                // Navigator.of(context).push(
                //   MaterialPageRoute(
                //     builder: (ctx) => const AddHiveScreen(),
                //   ),
                // );
              },
              backgroundColor: Theme.of(context).colorScheme.secondary,
              child: const Icon(Icons.add_home),
            ),
          ],
        ),
      ),
    );
  }
}
