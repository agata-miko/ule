import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pszczoly_v3/main.dart';
import 'package:pszczoly_v3/models/hive.dart';
import 'package:pszczoly_v3/screens/add_hive_screen.dart';
import 'package:pszczoly_v3/widgets/hives_list.dart';
import 'package:pszczoly_v3/providers/search_query_providers.dart';
import 'package:pszczoly_v3/widgets/sunset_widget.dart';
import 'package:sqflite/sqflite.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
        actions: [
          const SunsetWidget(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: PopupMenuButton<String>(
              icon: const Icon(Icons.language),
              //in case of more languages they can be moved to the list that would be used to create the items
              itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                PopupMenuItem<String>(
                    value: 'pl',
                    child: Text(AppLocalizations.of(context)!.polishFlag)),
                PopupMenuItem<String>(
                    value: 'en',
                    child: Text(AppLocalizations.of(context)!.englishFlag)),
              ],
              onSelected: (String? language) {
                if(language != null) {
                  MyApp.setLocale(context, Locale(language));
                }
              },
            ),
          ),
        ],
        leadingWidth: 100,
        leading: Center(
            child: Text(
          'ULala',
          style: TextStyle(
            fontFamily: GoogleFonts.zeyada().fontFamily,
            fontSize: 31,
          ),
        )),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
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
                            hintText: AppLocalizations.of(context)!
                                .hintHiveListSearch,
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
      bottomNavigationBar: Container(
        height: 20,
        child: Row(
          children: [
            RichText(
              text: TextSpan(
                  text: AppLocalizations.of(context)!.iconsBy,
                  style: Theme.of(context).textTheme.bodySmall,
                  children: <TextSpan>[
                    TextSpan(
                        text: AppLocalizations.of(context)!.icons8,
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(decoration: TextDecoration.underline),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            launchUrlString('https://icons8.com');
                          })
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}
