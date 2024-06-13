import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/search_query_notifier.dart';

class SearchBarWidget extends ConsumerWidget {
  const SearchBarWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextField(
      decoration: InputDecoration(
        labelText: 'Search Pokémon',
        suffixIcon: ref.watch(searchQueryProvider).isNotEmpty
            ? IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () =>
                    ref.read(searchQueryProvider.notifier).setSearchQuery(''),
              )
            : null,
      ),
      onChanged: (value) =>
          ref.read(searchQueryProvider.notifier).setSearchQuery(value),
    );
  }
}
