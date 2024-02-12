import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pszczoly_v3/models/hive.dart';
import 'package:pszczoly_v3/providers/hive_list_provider.dart';
import 'package:pszczoly_v3/screens/checklist_screen.dart';
import 'package:pszczoly_v3/providers/search_query_providers.dart';
import 'package:pszczoly_v3/screens/hive_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pszczoly_v3/providers/database_provider.dart';

class HivesList extends ConsumerStatefulWidget {
  const HivesList({super.key});

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
            child: Text(AppLocalizations.of(context)!.emptyHivesList),
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
            physics: NeverScrollableScrollPhysics(),
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
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop(
                                false); // Dismiss the dialog and reject the deletion
                          },
                          child: Text(AppLocalizations.of(context)!.cancel),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop(
                                true); // Dismiss the dialog and confirm the deletion
                          },
                          child: Text(AppLocalizations.of(context)!.remove),
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
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Container(width: MediaQuery.of(context).size.width * 0.9, decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ], color: Theme.of(context).colorScheme.primaryContainer,),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        leading:
                            (displayHives[index].photo?.path.isNotEmpty ?? false) &&
                                    File(displayHives[index].photo!.path).existsSync()
                                ? Container(
                                    width: 60,
                                    height: 60,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        // borderRadius: BorderRadius.circular(20),
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: FileImage(displayHives[index].photo!),
                                        )))
                                : Container(
                                    width: 60,
                                    height: 60,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.rectangle,
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                    child: const Icon(Icons.home_filled),
                                  ),
                        title: Text(
                          displayHives[index].hiveName,
                          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              color: Theme.of(context).colorScheme.onBackground),
                        ),
                        trailing: IconButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (ctx) => ChecklistScreen(
                                        hiveId: displayHives[index].hiveId!,
                                        hiveName: displayHives[index].hiveName,
                                      )));
                            },
                            icon: const Icon(
                              Icons.edit_note,
                              color: Colors.black54,
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
