import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pszczoly_v3/models/hive.dart';
import 'package:pszczoly_v3/providers/hive_list_provider.dart';
import 'package:pszczoly_v3/screens/checklist_screen.dart';
import 'package:pszczoly_v3/screens/hive_screen.dart';

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
          return const Padding(
            padding: EdgeInsets.all(20.0),
            child: Text('Zaden ul nie zostal jeszcze dodany. Dodaj teraz!'),
          );
        } else {
          final List<Hive> hivesList = snapshot.data!
              .map((row) =>
              Hive(
                hiveName: row['hiveName'] as String,
                hiveId: row['hiveId'] as String,
                photo: File('${row['photoPath']}'),
              ))
              .toList();
          return ListView.builder(
            itemCount: hivesList.length,
            itemBuilder: (context, index) =>
                Dismissible(
                  key: Key(hivesList[index].hiveId),
                  background: Container(color: Colors.red[300],
                    alignment: Alignment.centerRight,
                    child: const Icon(Icons.delete),),
                  confirmDismiss: (direction) async {
                    // Show confirmation dialog
                    return await showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Usunięcie ula'),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                '''Na pewno chcesz usunąć ul ${hivesList[index]
                                    .hiveName}? \n\nWszystkie checklisty dla ula zostaną nieodracalnie usunięte.''',
                                textAlign: TextAlign.left),
                              const SizedBox(height: 15,),
                              Text(
                                '''Tej operacji nie da się cofnąć!''',
                                textAlign: TextAlign.left, style: TextStyle(color: Theme.of(context).colorScheme.error),),
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
                    await ref.read(databaseProvider).deleteHive(hivesList[index].hiveId);
                    ref.read(hiveDataProvider.notifier).deleteHive(
                        hivesList[index].hiveId);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      leading: (hivesList[index].photo?.path.isNotEmpty ??
                          false) &&
                          File(hivesList[index].photo!.path).existsSync()
                          ? Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(5.0),
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: FileImage(hivesList[index].photo!),
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
                        hivesList[index].hiveName,
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
                      trailing: IconButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (ctx) =>
                                    ChecklistScreen(
                                      hiveId: hivesList[index].hiveId,
                                      hiveName: hivesList[index].hiveName,
                                    )));
                          },
                          icon: const Icon(Icons.checklist)),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) =>
                                HiveScreen(
                                    hiveName: hivesList[index].hiveName,
                                    selectedImage: hivesList[index].photo,
                                    hiveId: hivesList[index].hiveId),
                          ),
                        );
                      },
                    ),
                  ),
                ),
          );
        }
      },
    );
  }
}
