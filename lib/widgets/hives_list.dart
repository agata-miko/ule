import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pszczoly_v3/models/hive.dart';
import 'package:pszczoly_v3/providers/hive_list_provider.dart';
import 'package:pszczoly_v3/screens/checklist_screen.dart';
import 'package:pszczoly_v3/screens/hive_screen.dart';

class HivesList extends ConsumerWidget {
  const HivesList({super.key});

  // final List<Hive> hives;

  @override
  Widget build(BuildContext context, ref) {
    final List<Hive> hives = ref.watch(hiveDataProvider);
    return (hives.isEmpty)
        ? const Padding(
            padding: EdgeInsets.all(20.0),
            child: Text('Zaden ul nie zostal jeszcze dodany. Dodaj teraz!'),
          )
        : ListView.builder(
            itemCount: hives.length,
            itemBuilder: (context, index) => ListTile(
              leading: CircleAvatar(
                  radius: 26,
                  backgroundImage: hives[index].photo != null
                      ? FileImage(hives[index].photo!)
                      : null),
              title: Text(
                hives[index].hiveName,
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground),
              ),
              trailing: IconButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (ctx) => ChecklistScreen(
                              hiveId: hives[index].hiveId,
                              hiveName: hives[index].hiveName,
                            )));
                  },
                  icon: const Icon(Icons.checklist)),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => HiveScreen(
                        hiveName: hives[index].hiveName,
                        selectedImage: hives[index].photo,
                        hiveId: hives[index].hiveId),
                  ),
                );
              },
            ),
          );
  }
}
