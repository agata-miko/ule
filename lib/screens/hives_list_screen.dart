import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pszczoly_v3/main.dart';
import 'package:pszczoly_v3/models/hive.dart';
import 'package:pszczoly_v3/models/language_constants.dart';
import 'package:pszczoly_v3/screens/add_hive_screen.dart';
import 'package:pszczoly_v3/widgets/hives_list.dart';
import 'package:pszczoly_v3/providers/search_query_providers.dart';
import 'package:pszczoly_v3/widgets/sunset_widget.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pszczoly_v3/widgets/search_bar_hive.dart';
import 'package:pszczoly_v3/providers/hive_search_bar_bool_provider.dart';

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
    bool searchBool = ref.watch(searchBarVisibilityProvider);
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        extendBody: true,
        // floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
        appBar: AppBar(
          centerTitle: false,
          title: searchBool == false
              ? Text(
                  'ULE',
                  style: Theme.of(context).appBarTheme.titleTextStyle!.copyWith(
                        fontFamily: GoogleFonts.plaster().fontFamily,
                      ),
                )
              : SearchBarHive(searchController: _searchController),
          actions: [
            IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {
                  _searchController.clear();
                  ref
                      .read(hivesSearchQueryProvider.notifier)
                      .updateSearchQuery('');
                  ref
                      .read(searchBarVisibilityProvider.notifier)
                      .toggleSearchBool();
                }),
            PopupMenuButton<String>(
              color: Theme.of(context).colorScheme.primaryContainer,
              elevation: 0,
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
              offset: const Offset(0, 40),
              onSelected: (String? language) async {
                if (language != null) {
                  Locale? locale = await setLocale(language);
                  if (!context.mounted) return;
                  MyApp.setLocale(context, locale!);
                }
              },
            ),
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                _showAddHiveModal(context);
              },
            ),
          ],
        ),
        body: MediaQuery.removePadding(
          context: context,
          removeTop: true,
          child: Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/background_1.png'),
                    fit: BoxFit.cover)),
            height: MediaQuery.of(context).size.height,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.1,
                      right: MediaQuery.of(context).size.width * 0.08,
                      bottom: MediaQuery.of(context).size.height * 0.02,
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SunsetWidget(),
                      ],
                    ),
                  ),
                  // Text(
                  //   'Twoje ule:',
                  //   style: Theme.of(context)
                  //       .textTheme
                  //       .bodyLarge!.copyWith(fontWeight: FontWeight.bold)
                  // ),
                  HivesList(modalFunction: () {
                    _showAddHiveModal(context);
                  }),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.1,
                  ),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: Container(
          decoration: const BoxDecoration(
            color: Colors.transparent,
          ),
          height: MediaQuery.of(context).size.height * 0.15,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // FloatingActionButton(
              //   onPressed: () {
              //     _showAddHiveModal(context);
              //     // Navigator.of(context).push(
              //     //   MaterialPageRoute(
              //     //     builder: (ctx) => const AddHiveScreen(),
              //     //   ),
              //     // );
              //   },
              //   shape: const CircleBorder(),
              //   backgroundColor: Colors.white,
              //   elevation: 16,
              //   child: const Icon(
              //     Icons.add_home,
              //   ),
              // ),
              // Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: <Widget>[
              //   // IconButton(onPressed: () {}, icon: Icon(Icons.home)),
              //   IconButton(onPressed: () {_showAddHiveModal(context);}, icon: Icon(Icons.add_home)),
              // ],
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primaryContainer),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    RichText(
                      text: TextSpan(
                          text: AppLocalizations.of(context)!.iconsBy,
                          style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 10),
                          children: <TextSpan>[
                            TextSpan(
                                text: AppLocalizations.of(context)!.icons8,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(fontSize: 10,
                                        decoration: TextDecoration.underline),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    launchUrlString('https://icons8.com');
                                  })
                          ]),
                    ),
                    const VerticalDivider(
                      thickness: 1,
                      color: Colors.black,
                    ),
                    RichText(
                      text: TextSpan(
                        text: AppLocalizations.of(context)!.sunData,
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 10),
                        children: <TextSpan>[
                          TextSpan(
                            text: AppLocalizations.of(context)!.ssIo,
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(fontSize: 10, decoration: TextDecoration.underline),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                launchUrlString('https://sunrisesunset.io');
                              },
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
