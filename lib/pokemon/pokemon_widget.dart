import 'package:api_test/services/pokemon_service.dart';
import 'package:api_test/utils/string_capitalization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PokemonWidget extends ConsumerWidget {
  final String pokemonName;

  const PokemonWidget({super.key, required this.pokemonName});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncPokemon = ref.watch(pokemonProvider(pokemonName));

    return asyncPokemon.when(
      data: (pokemon) => Column(
        children: [
          Image.network(
              'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/${pokemon.id}.png'),
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
            'Types: ${pokemon.types.map((type) => type.type.name.capitalize()).join(', ')}',
          ),
        ],
      ),
      loading: () => const CircularProgressIndicator(),
      error: (error, stack) => Text('Error: $error'),
    );
  }
}
