import 'package:api_test/services/pokemon_service.dart';
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
          Text('ID: ${pokemon.id}'),
          Text('Name: ${pokemon.name}'),
          Text('Height: ${pokemon.height}'),
          Text('Weight: ${pokemon.weight}'),
          Text(
            'Types: ${pokemon.types.map((type) => type.type.name).join(', ')}',
          ),
        ],
      ),
      loading: () => const CircularProgressIndicator(),
      error: (error, stack) => Text('Error: $error'),
    );
  }
}
