import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokemons/presentation/screens/home/pages/pokedex_page.dart';
import 'package:pokemons/presentation/providers/pokemon_list_provider.dart';
import 'package:pokemons/presentation/providers/pokemon_detail_provider.dart';
import 'package:pokemons/core/constants/app_constants.dart';
import 'package:pokemons/domain/entities/pokemon.dart';
import 'package:pokemons/domain/entities/pokemon_detail.dart';
import 'package:pokemons/presentation/widgets/pokemon_card.dart';
import 'test_utils.dart';

void main() {
  setUp(() {
    // Reset state before each test
    AppConstants.forcePokemonListError = false;
  });

  testWidgets('Error flow: show error state and recover after retry',
      (WidgetTester tester) async {
    final mockPokemons = [
      const Pokemon(id: 1, name: 'bulbasaur', url: ''),
    ];

    // Enable error forcing
    AppConstants.forcePokemonListError = true;

    await tester.pumpWidget(
      createTestWidget(
        overrides: [
          pokemonListFutureProvider.overrideWith((ref) async => mockPokemons),
          pokemonDetailProvider.overrideWith((ref, key) async => PokemonDetail(
                id: 1,
                name: key.name,
                imageUrl: '',
                height: 7,
                weight: 69,
                types: ['grass'],
                stats: {},
              )),
        ],
        child: const PokedexPage(),
      ),
    );

    // Initial load - Should show error
    await tester.pumpAndSettle();
    
    expect(find.text('Algo salió mal...'), findsOneWidget);
    expect(find.text('Reintentar'), findsOneWidget);
    expect(find.byType(PokemonCard), findsNothing);

    // Tap Retry
    await tester.tap(find.text('Reintentar'));
    
    // We need to pump multiple times to allow invalidation and re-fetch
    await tester.pump(); // Triggers onPressed
    await tester.pump(); // Triggers rebuild after state changes
    await tester.pumpAndSettle(); // Wait for any remaining animations

    // Verify error is gone and Bulbasaur is shown
    expect(find.text('Algo salió mal...'), findsNothing);
    expect(find.text('Bulbasaur'), findsOneWidget);
    expect(find.byType(PokemonCard), findsOneWidget);
    expect(AppConstants.forcePokemonListError, isFalse);
  });
}
