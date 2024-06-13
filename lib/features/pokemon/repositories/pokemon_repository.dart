import 'dart:convert';

import 'package:api_test/features/pokemon/models/pokemon_model.dart';
import 'package:http/http.dart' as http;

class PokemonRepository {
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
