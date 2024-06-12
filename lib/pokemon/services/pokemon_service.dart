import 'dart:convert';

import 'package:api_test/pokemon/models/pokemon_model.dart';
import 'package:api_test/search_bar/search_query_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

class PokemonService {
  static const String _baseUrl = 'https://pokeapi.co/api/v2/pokemon/';

  Future<Pokemon> fetchPokemon(String name) async {
    final response = await http.get(Uri.parse('$_baseUrl$name'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return Pokemon.fromJson(data);
    } else {
      throw Exception('Failed to load Pokemon');
    }
  }
}

final pokemonServiceProvider = Provider<PokemonService>((ref) {
  return PokemonService();
});

final pokemonProvider = FutureProvider<Pokemon?>((ref) async {
  final query = ref.watch(searchQueryProvider);
  if (query.isEmpty) {
    return Future.value(null);
  }
  final service = ref.read(pokemonServiceProvider);
  return service.fetchPokemon(query);
});
