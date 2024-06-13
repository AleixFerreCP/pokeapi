import 'package:api_test/features/pokemon/models/pokemon_model.dart';
import 'package:api_test/features/pokemon/repositories/pokemon_repository.dart';
import 'package:api_test/features/search_bar/providers/search_query_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final pokemonRepositoryProvider =
    Provider<PokemonRepository>((ref) => PokemonRepository());

final pokemonProvider = FutureProvider<Pokemon?>((ref) async {
  final query = ref.watch(searchQueryProvider);
  if (query.isEmpty) {
    return Future.value(null);
  }
  final service = ref.watch(pokemonRepositoryProvider);
  return service.fetchPokemon(query);
});
