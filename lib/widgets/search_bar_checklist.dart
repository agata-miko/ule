import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:pszczoly_v3/providers/calendar_date_provider.dart';
import 'package:pszczoly_v3/providers/search_query_providers.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SearchBarChecklist extends ConsumerWidget {
  const SearchBarChecklist({
    super.key,
    required TextEditingController searchController,
    required this.selectedDate,
  }) : _searchController = searchController;

  final TextEditingController _searchController;
  final DateTime? selectedDate;

  @override
  Widget build(BuildContext context, ref) {
    return TextField(
      controller: _searchController,
      onChanged: (query) {
        ref
            .read(checklistSearchQueryProvider.notifier)
            .updateSearchQuery(query);
      },
      decoration: InputDecoration(suffixIcon: IconButton(
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
          hintText: selectedDate != null
              ? DateFormat('dd/MM/yyyy')
              .format(selectedDate!)
              : AppLocalizations.of(context)!
              .hintSearch,
          hintStyle: Theme.of(context).textTheme.bodyMedium,
    ));
  }
}