import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pszczoly_v3/providers/search_query_providers.dart';
import 'package:pszczoly_v3/widgets/checklists_list.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ChecklistListScreen extends ConsumerWidget {
  ChecklistListScreen({super.key, required this.hiveId, required this.hiveName});

  final String hiveId;
  final String hiveName;

  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context, ref) {
    ref.watch(checklistSearchQueryProvider);
    return Scaffold(
      appBar: AppBar(
        title: FittedBox(fit: BoxFit.scaleDown, child: Text(hiveName)),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.height * 0.04),
                  child: TextField(
                    controller: _searchController,
                    onChanged: (query) {
                      ref.read(checklistSearchQueryProvider.notifier).updateSearchQuery(query);
                    },
                    decoration: InputDecoration(
                        hintText: AppLocalizations.of(context)!.hintChecklistSearch,
                        hintStyle: Theme.of(context).textTheme.bodyMedium,
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: ()  {_searchController.clear();
                          ref.read(checklistSearchQueryProvider.notifier).updateSearchQuery('');
                          FocusScope.of(context).unfocus();},
                        ),
                        prefixIcon: IconButton(
                          icon: const Icon(Icons.search),
                          onPressed: () {},
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(20))),
                  ),
                ),
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.8, child: Center(child: ListOfChecklists(hiveId: hiveId, hiveName: hiveName,))),
          ],
        ),
      ),
    );
  }
}
