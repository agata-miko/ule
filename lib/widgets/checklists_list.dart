import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pszczoly_v3/providers/hive_list_provider.dart';
import 'package:pszczoly_v3/providers/search_query_providers.dart';
import 'package:pszczoly_v3/screens/filled_checklist_screen.dart';
import 'package:pszczoly_v3/models/checklist.dart';

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
          return const Padding(
            padding: EdgeInsets.all(20.0),
            child: Text('Brak checklist dla tego ula'),
          );
        } else {
          final List<Checklist> checklistList = snapshot.data!
              .map((row) =>
              Checklist(
                checklistId: row['checklistId'] as String,
                hiveId: row['hiveId'] as String,
                checklistDate: DateTime.fromMillisecondsSinceEpoch(
                    int.parse(row[
                    'checklistDate'])), // Convert timestamp to DateTime
              ))
              .toList();

          List<Checklist> displayChecklists = searchQuery.isEmpty && searchQuery == null
              ? checklistList
              : checklistList
              .where((checklist) => checklist.checklistDate.toString()
              .toLowerCase()
              .contains(searchQuery.toLowerCase()))
              .toList();

          return ListView.builder(
            itemCount: displayChecklists.length,
            itemBuilder: (context, index) =>
                Dismissible(
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
                          title: const Text('Usunięcie checklisty'),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text('Na pewno chcesz usunąć checklistę?',
                                  textAlign: TextAlign.left),
                              const SizedBox(
                                height: 15,
                              ),
                              Text(
                                'Tej operacji nie da się cofnąć!',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: Theme
                                        .of(context)
                                        .colorScheme
                                        .error),
                              ),
                            ],
                          ),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop(
                                    false); // Dismiss the dialog and reject the deletion
                              },
                              child: const Text('Anuluj'),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop(
                                    true); // Dismiss the dialog and confirm the deletion
                              },
                              child: const Text('Usuń'),
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
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      title: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Row(
                          children: [
                            const Icon(Icons.list),
                            const SizedBox(width: 30),
                            Text(
                              DateFormat.yMd()
                                  .format(displayChecklists[index].checklistDate),
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(
                                  color: Theme
                                      .of(context)
                                      .colorScheme
                                      .onBackground),
                            ),
                          ],
                        ),
                      ),
                      onTap: () {Navigator.of(context).push(MaterialPageRoute(
                          builder: (ctx) => FilledChecklistScreen(hiveId: widget.hiveId,
                              checklistId: displayChecklists[index].checklistId,
                              checklistDate: displayChecklists[index].checklistDate,
                              hiveName: widget.hiveName)));},
                    ),
                  ),
                ),
          );
        }
      },
    );
  }
}
