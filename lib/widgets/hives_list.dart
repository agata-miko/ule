import 'dart:io';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pszczoly_v3/models/hive.dart';
import 'package:pszczoly_v3/providers/hive_list_provider.dart';
import 'package:pszczoly_v3/screens/checklist_screen.dart';
import 'package:pszczoly_v3/providers/search_query_providers.dart';
import 'package:pszczoly_v3/screens/hive_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pszczoly_v3/providers/database_provider.dart';

import '../models/language_constants.dart';

class HivesList extends ConsumerStatefulWidget {
  const HivesList({super.key, required this.modalFunction});

  final void Function() modalFunction;

  @override
  ConsumerState<HivesList> createState() {
    return _HivesListState();
  }
}

class _HivesListState extends ConsumerState<HivesList> {
  @override
  Widget build(BuildContext context) {
    final searchQuery = ref.watch(hivesSearchQueryProvider);
    ref.watch(hiveDataProvider);
    final Future<List<Map<String, dynamic>>> hivesListFromDatabase =
        ref.read(databaseProvider).getAllHives();

    return FutureBuilder<List<Map<String, dynamic>>>(
      future: hivesListFromDatabase,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: Theme.of(context).textTheme.bodyMedium,
                  children: [
                    TextSpan(
                      text: '${translation(context).emptyHivesList}\n',
                    ),
                    TextSpan(
                      text: translation(context).addOneNow,
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          // Handle the onPressed action for the "addOneNow" text here
                          widget.modalFunction();
                        },
                    ),
                  ],
                ),
              ),
            ),
          );
        } else {
          final List<Hive> hivesList = snapshot.data!
              .map((row) => Hive(
                    hiveName: row['hiveName'] as String,
                    hiveId: row['hiveId'],
                    photo: File('${row['photoPath']}'),
                  ))
              .toList();
          List<Hive> displayHives = searchQuery.isEmpty
              ? hivesList
              : hivesList
                  .where((hive) => hive.hiveName
                      .toLowerCase()
                      .contains(searchQuery.toLowerCase()))
                  .toList();
          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: displayHives.length,
            itemBuilder: (context, index) => Dismissible(
              key: Key(displayHives[index].hiveId!.toString()),
              background: Container(
                color: Colors.red[300],
                alignment: Alignment.centerRight,
                child: const Icon(Icons.delete),
              ),
              confirmDismiss: (direction) async {
                // Show confirmation dialog
                return await showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text(
                        AppLocalizations.of(context)!.hiveRemoval,
                        textAlign: TextAlign.center,
                      ),
                      content: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            AppLocalizations.of(context)!
                                .confirmHiveRemovalTitle(
                                    displayHives[index].hiveName),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(AppLocalizations.of(context)!
                              .confirmHiveRemovalContent),
                          const SizedBox(
                            height: 15,
                          ),
                          Text(
                            AppLocalizations.of(context)!.theOpIsNotReversible,
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.error),
                          ),
                        ],
                      ),
                      actions: <Widget>[
                        ButtonBar(
                          alignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop(
                                    false); // Dismiss the dialog and reject the deletion
                              },
                              child: Text(
                                AppLocalizations.of(context)!.cancel,
                                style:
                                    const TextStyle(color: Color(0xFF1B2805)),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop(
                                    true); // Dismiss the dialog and confirm the deletion
                              },
                              child: Text(AppLocalizations.of(context)!.remove,
                                  style: const TextStyle(
                                      color: Color(0xFF1B2805))),
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                );
              },
              onDismissed: (direction) async {
                await ref
                    .read(databaseProvider)
                    .deleteHive(displayHives[index].hiveId!);
                ref
                    .read(hiveDataProvider.notifier)
                    .deleteHive(displayHives[index].hiveId!);
                ref
                    .read(hivesSearchQueryProvider.notifier)
                    .updateSearchQuery('');
              },
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          spreadRadius: 1,
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                      color: Theme.of(context).colorScheme.primaryContainer,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: (displayHives[index].photo?.path.isNotEmpty ??
                                    false) &&
                                File(displayHives[index].photo!.path)
                                    .existsSync()
                            ? Container(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    borderRadius: BorderRadius.circular(90),
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image:
                                          FileImage(displayHives[index].photo!),
                                    )))
                            //backgroundImage: FileImage(displayHives[index].photo!), radius: 32,))
                            : Container(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                child: const Icon(
                                  Icons.home_filled,
                                  color: Color(0xFF1B2805),
                                ),
                              ),
                        title: Text(displayHives[index].hiveName,
                            style: Theme.of(context).textTheme.bodyLarge),
                        trailing: IconButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (ctx) => ChecklistScreen(
                                        hiveId: displayHives[index].hiveId!,
                                        hiveName: displayHives[index].hiveName,
                                      )));
                            },
                            icon: CircleAvatar(
                              backgroundColor: Color(0xFF233406),
                              child: const Icon(
                                Icons.edit_note,
                                color: Colors.white,
                              ),
                            )),
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => HiveScreen(
                                  hiveName: displayHives[index].hiveName,
                                  selectedImage: displayHives[index].photo,
                                  hiveId: displayHives[index].hiveId!),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
