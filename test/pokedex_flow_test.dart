import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokemons/presentation/screens/home/pages/pokedex_page.dart';
import 'package:pokemons/presentation/providers/pokemon_list_provider.dart';
import 'package:pokemons/presentation/providers/pokemon_detail_provider.dart';
import 'package:pokemons/domain/entities/pokemon.dart';
import 'package:pokemons/domain/entities/pokemon_detail.dart';
import 'package:pokemons/presentation/widgets/pokemon_card.dart';
import 'test_utils.dart';

void main() {
  testWidgets('Pokedex flow: load list and search by name',
      (WidgetTester tester) async {
    final mockPokemons = [
      const Pokemon(id: 1, name: 'bulbasaur', url: ''),
      const Pokemon(id: 4, name: 'charmander', url: ''),
      const Pokemon(id: 7, name: 'squirtle', url: ''),
    ];

    await tester.pumpWidget(
      createTestWidget(
        overrides: [
          pokemonListFutureProvider.overrideWith((ref) async => mockPokemons),
          // Necesario porque PokemonCard hace ref.watch(pokemonDetailProvider)
          pokemonDetailProvider.overrideWith((ref, key) async => PokemonDetail(
                id: 1,
                name: key.name,
                imageUrl: '',
                height: 7,
                weight: 69,
                types: ['grass', 'poison'],
                stats: {},
                category: 'Seed',
                abilities: ['overgrow'],
              )),
        ],
        child: const PokedexPage(),
      ),
    );

    // Initial load
    await tester.pumpAndSettle();

    // Verify all 3 are shown (Capitalized names in PokemonCard)
    expect(find.byType(PokemonCard), findsNWidgets(3));
    expect(find.text('Bulbasaur'), findsOneWidget);
    expect(find.text('Charmander'), findsOneWidget);
    expect(find.text('Squirtle'), findsOneWidget);

    // Search for 'char'
    final searchField = find.byType(TextField);
    expect(searchField, findsOneWidget);

    await tester.enterText(searchField, 'char');
    await tester.pumpAndSettle();

    // Verify only charmander is shown
    expect(find.text('Charmander'), findsOneWidget);
    expect(find.text('Bulbasaur'), findsNothing);
    expect(find.text('Squirtle'), findsNothing);
    expect(find.byType(PokemonCard), findsOneWidget);
  });
}
