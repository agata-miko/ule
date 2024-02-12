import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pszczoly_v3/providers/search_query_providers.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SearchBarHive extends ConsumerWidget {
  const SearchBarHive({
    super.key,
    required TextEditingController searchController,
  }) : _searchController = searchController;

  final TextEditingController _searchController;

  @override
  Widget build(BuildContext context, ref) {
    return TextField(
        controller: _searchController,
        onChanged: (query) {
          ref.read(hivesSearchQueryProvider.notifier).updateSearchQuery(query);
        },
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
              vertical: MediaQuery.of(context).size.height * 0.001),
          hintText: AppLocalizations.of(context)!.hintHiveListSearch,
          hintStyle: Theme.of(context).textTheme.bodyMedium,
        ));
  }
}
