import 'package:api_test/pokemon/models/pokemon_model.dart';
import 'package:api_test/pokemon/services/pokemon_service.dart';
import 'package:api_test/utils/string_capitalization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PokemonWidget extends ConsumerWidget {
  const PokemonWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncPokemon = ref.watch(pokemonProvider);

    return asyncPokemon.when(
      data: (pokemon) => pokemon == null
          ? const Text("no pokemon")
          : Column(
              children: [
                Image.network(
                  'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/${pokemon.id}.png',
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '#${pokemon.id}',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(pokemon.name.capitalize()),
                  ],
                ),
                Text('Height: ${pokemon.height}'),
                Text('Weight: ${pokemon.weight}'),
                Text(
                  'Types: ${listTypes(pokemon)}',
                ),
              ],
            ),
      loading: () => const CircularProgressIndicator(),
      error: (error, stack) => Text('Error: $error'),
    );
  }

  String listTypes(Pokemon pokemon) =>
      pokemon.types.map((type) => type.type.name.capitalize()).join(', ');
}
