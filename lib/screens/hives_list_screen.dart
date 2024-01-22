import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
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
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      appBar: AppBar(
        leadingWidth: 100,
        leading: Center(
            child: Text(
          'ULala',
          style: TextStyle(
            fontFamily: GoogleFonts.zeyada().fontFamily,
            fontSize: 31,
          ),
        )),
        // title: const Text('Moje ule'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            // Text('Dodane ule', style: Theme.of(context).textTheme.bodyLarge,),
            // const SizedBox(height: 10,),
            // const Divider(thickness: 0.1),
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
                          ref
                              .read(hivesSearchQueryProvider.notifier)
                              .updateSearchQuery(query);
                        },
                        decoration: InputDecoration(
                            hintText: 'Znajdź ul...',
                            hintStyle: Theme.of(context).textTheme.bodyMedium,
                            suffixIcon: IconButton(
                              icon: const Icon(Icons.clear),
                              onPressed: () {
                                _searchController.clear();
                                ref
                                    .read(hivesSearchQueryProvider.notifier)
                                    .updateSearchQuery('');
                                FocusScope.of(context).unfocus();
                              },
                            ),
                            prefixIcon: IconButton(
                              icon: const Icon(Icons.search),
                              onPressed: () {},
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(20))),
                      )),
                ),
                SizedBox(height: 10,)
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
            // const SizedBox(
            //   height: 10,
            // ),
            const SizedBox(height: 380, child: HivesList()),
            FloatingActionButton(
              onPressed: () {
                _showAddHiveModal(context);
                // Navigator.of(context).push(
                //   MaterialPageRoute(
                //     builder: (ctx) => const AddHiveScreen(),
                //   ),
                // );
              },
              shape: CircleBorder(),
              backgroundColor: Colors.white,
              elevation: 8,
              child: const Icon(Icons.add_home),
            ),
          ],
        ),
      ),
    );
  }
}
