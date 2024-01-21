import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pszczoly_v3/widgets/checklists_list.dart';

class ChecklistListScreen extends ConsumerWidget {
  ChecklistListScreen({super.key, required this.hiveId, required this.hiveName});

  final String hiveId;
  final String hiveName;

  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context, ref) {
    return Scaffold(
      appBar: AppBar(
        title: FittedBox(fit: BoxFit.scaleDown, child: Text(hiveName)),
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
                        decoration: InputDecoration(
                            hintText: 'Znajdź checklistę...',
                            hintStyle: Theme.of(context).textTheme.bodyMedium,
                            suffixIcon: IconButton(
                              icon: const Icon(Icons.clear),
                              onPressed: ()  {_searchController.clear();},
                            ),
                            prefixIcon: IconButton(
                              icon: const Icon(Icons.search),
                              onPressed: () {}, // tutaj wyszukiwanie
                            ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20))),
                      )),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(height: 340, child: Center(child: ListOfChecklists(hiveId: hiveId, hiveName: hiveName,))),
          ],
        ),
      ),
    );
  }
}
