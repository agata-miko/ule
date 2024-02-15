import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:pszczoly_v3/providers/calendar_date_provider.dart';
import 'package:pszczoly_v3/providers/checklist_search_bar_bool_provider.dart';
import 'package:pszczoly_v3/providers/hive_search_bar_bool_provider.dart';
import 'package:pszczoly_v3/providers/search_query_providers.dart';
import 'package:pszczoly_v3/widgets/checklists_list.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pszczoly_v3/widgets/search_bar_checklist.dart';
import 'package:pszczoly_v3/widgets/search_bar_hive.dart';

class ChecklistListScreen extends ConsumerWidget {
  ChecklistListScreen(
      {super.key, required this.hiveId, required this.hiveName});

  final int hiveId;
  final String hiveName;

  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context, ref) {
    ref.watch(checklistSearchQueryProvider);
    bool searchBool = ref.watch(searchBarVisibilityProviderChecklists);
    final selectedDate = ref.watch(selectedDateProvider);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          actions: [IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                _searchController.clear();
                ref
                    .read(checklistSearchQueryProvider.notifier)
                    .updateSearchQuery('');
                ref
                    .read(selectedDateProvider.notifier)
                    .setSelectedDate(null);
                ref
                    .read(searchBarVisibilityProviderChecklists.notifier)
                    .toggleSearchBool();
              }),
            ],
          title: searchBool == false
              ? FittedBox(fit: BoxFit.scaleDown, child: Text(hiveName))
              : SearchBarChecklist(searchController: _searchController, selectedDate: selectedDate),
        ),
        body: SingleChildScrollView(
          child:
              SizedBox(
                  height: MediaQuery.of(context).size.height * 0.8,
                  child: Center(
                      child: ListOfChecklists(
                    hiveId: hiveId,
                    hiveName: hiveName,
                  ))),
          ),
        ),

    );
  }
}
