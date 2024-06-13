import 'package:api_test/features/pokemon/widgets/pokemon_widget.dart';
import 'package:api_test/features/search_bar/widgets/search_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PokeAPI',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
        useMaterial3: true,
      ),
      home: Scaffold(
        appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            title: const Text('PokeAPI')),
        body: const Column(
          children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: SearchBarWidget(),
            ),
            Expanded(
              child: Center(child: PokemonWidget()),
            ),
          ],
        ),
      ),
    );
  }
}
