import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:pszczoly_v3/providers/calendar_date_provider.dart';
import 'package:pszczoly_v3/providers/search_query_providers.dart';
import 'package:pszczoly_v3/widgets/checklists_list.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ChecklistListScreen extends ConsumerWidget {
  ChecklistListScreen(
      {super.key, required this.hiveId, required this.hiveName});

  final int hiveId;
  final String hiveName;

  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context, ref) {
    ref.watch(checklistSearchQueryProvider);
    final selectedDate = ref.watch(selectedDateProvider);
    return SafeArea(
      child: Scaffold(
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
                    padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.height * 0.04),
                    child: Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.calendar_today),
                          onPressed: () async {
                            DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: selectedDate ?? DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2101),
                            );

                            ref
                                .read(selectedDateProvider.notifier)
                                .setSelectedDate(pickedDate!);
                            ref
                                .read(checklistSearchQueryProvider.notifier)
                                .updateSearchQuery( DateFormat('dd/MM/yyyy').format(pickedDate).toString());
                          },
                        ),
                        Expanded(
                          child: TextField(
                            controller: _searchController,
                            onChanged: (query) {
                              ref
                                  .read(checklistSearchQueryProvider.notifier)
                                  .updateSearchQuery(query);
                            },
                            decoration: InputDecoration(
                                hintText: selectedDate != null
                                    ? DateFormat('dd/MM/yyyy')
                                        .format(selectedDate)
                                    : AppLocalizations.of(context)!
                                        .hintChecklistSearch,
                                hintStyle: Theme.of(context).textTheme.bodyMedium,
                                suffixIcon: IconButton(
                                  icon: const Icon(Icons.clear),
                                  onPressed: () {
                                    _searchController.clear();
                                    ref
                                        .read(
                                            checklistSearchQueryProvider.notifier)
                                        .updateSearchQuery('');
                                    ref
                                        .read(selectedDateProvider.notifier)
                                        .setSelectedDate(null);
                                    FocusScope.of(context).unfocus();
                                  },
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
                  ),
                ],
              ),
              SizedBox(
                  height: MediaQuery.of(context).size.height * 0.8,
                  child: Center(
                      child: ListOfChecklists(
                    hiveId: hiveId,
                    hiveName: hiveName,
                  ))),
            ],
          ),
        ),
      ),
    );
  }
}
