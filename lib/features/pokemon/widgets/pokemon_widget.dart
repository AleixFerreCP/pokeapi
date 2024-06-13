import 'package:api_test/features/pokemon/models/pokemon_model.dart';
import 'package:api_test/features/pokemon/providers/pokemon_provider.dart';
import 'package:api_test/utils/string_capitalization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PokemonWidget extends ConsumerWidget {
  const PokemonWidget({super.key});

  String listTypes(Pokemon pokemon) =>
      pokemon.types.map((type) => type.type.name.capitalize()).join(', ');

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncPokemon = ref.watch(pokemonProvider);

    return asyncPokemon.when(
      data: (pokemon) {
        if (pokemon == null) {
          return const Text("no pokemon");
        }
        return Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3),
              ),
            ],
            border: Border.all(
              color: Theme.of(context).primaryColor,
            ),
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
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
              Text('Types: ${listTypes(pokemon)}'),
            ],
          ),
        );
      },
      loading: () => const CircularProgressIndicator(),
      error: (error, stack) => Text('Error: $error'),
    );
  }
}
