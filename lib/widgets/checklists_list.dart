import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pszczoly_v3/providers/hive_list_provider.dart';
import 'package:pszczoly_v3/providers/search_query_providers.dart';
import 'package:pszczoly_v3/screens/filled_checklist_screen.dart';
import 'package:pszczoly_v3/models/checklist.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ListOfChecklists extends ConsumerStatefulWidget {
  const ListOfChecklists(
      {super.key, required this.hiveId, required this.hiveName});

  final String hiveId;
  final String hiveName;

  @override
  ConsumerState<ListOfChecklists> createState() {
    return _ListOfChecklists();
  }
}

class _ListOfChecklists extends ConsumerState<ListOfChecklists> {
  @override
  Widget build(BuildContext context) {
    final searchQuery = ref.watch(checklistSearchQueryProvider);
    ref.watch(hiveDataProvider);
    final Future<List<Map<String, dynamic>>> hivesListFromDatabase =
        ref.read(databaseProvider).getChecklistsForAHive(widget.hiveId);

    return FutureBuilder<List<Map<String, dynamic>>>(
      future: hivesListFromDatabase,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Padding(
            padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.04),
            child: Text(AppLocalizations.of(context)!.noChecklists),
          );
        } else {
          final List<Checklist> checklistList = snapshot.data!
              .map((row) => Checklist(
                    checklistId: row['checklistId'] as String,
                    hiveId: row['hiveId'] as String,
                    checklistDate: DateTime.fromMillisecondsSinceEpoch(
                        int.parse(row[
                            'checklistDate'])), // Convert timestamp to DateTime
                  ))
              .toList();

          List<Checklist> displayChecklists =
              searchQuery.isEmpty
                  ? checklistList
                  : checklistList
                      .where((checklist) => checklist.checklistDate
                          .toString()
                          .toLowerCase()
                          .contains(searchQuery.toLowerCase()))
                      .toList();

          return ListView.builder(
            itemCount: displayChecklists.length,
            itemBuilder: (context, index) => Dismissible(
              key: Key(displayChecklists[index].checklistId),
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
                      title:
                          Text(AppLocalizations.of(context)!.checklistRemoval),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                              AppLocalizations.of(context)!
                                  .confirmChecklistRemovalTitle,
                              textAlign: TextAlign.left),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.04,
                          ),
                          Text(
                            AppLocalizations.of(context)!.theOpIsNotReversible,
                            textAlign: TextAlign.left,
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
                    .deleteChecklist(displayChecklists[index].checklistId);
              },
              child: ListTile(
                title: Padding(
                  padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.height * 0.05),
                  child: Row(
                    children: [
                      const Icon(Icons.list),
                      SizedBox(width: MediaQuery.of(context).size.width * 0.1),
                      Text(
                        DateFormat.yMd()
                            .format(displayChecklists[index].checklistDate),
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(
                                color: Theme.of(context)
                                    .colorScheme
                                    .onBackground),
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (ctx) => FilledChecklistScreen(
                          hiveId: widget.hiveId,
                          checklistId: displayChecklists[index].checklistId,
                          checklistDate:
                              displayChecklists[index].checklistDate,
                          hiveName: widget.hiveName)));
                },
              ),
            ),
          );
        }
      },
    );
  }
}
