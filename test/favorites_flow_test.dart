import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokemons/presentation/screens/home/pages/favoritos_page.dart';
import 'package:pokemons/presentation/providers/pokemon_list_provider.dart';
import 'package:pokemons/presentation/providers/pokemon_detail_provider.dart';
import 'package:pokemons/presentation/providers/favorites_provider.dart';
import 'package:pokemons/domain/entities/pokemon.dart';
import 'package:pokemons/domain/entities/pokemon_detail.dart';
import 'package:pokemons/presentation/widgets/swipeable_favorite_item.dart';
import 'test_utils.dart';

void main() {
  testWidgets('Favorites flow: empty state and adding/removing favorites',
      (WidgetTester tester) async {
    final mockPokemons = [
      const Pokemon(id: 1, name: 'bulbasaur', url: ''),
    ];

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
        child: const FavoritosPage(),
      ),
    );

    // Initial load - Empty state
    await tester.pumpAndSettle();
    expect(find.text('No has marcado ningún Pokémon como favorito'), findsOneWidget);

    // Add Bulbasaur to favorites
    final BuildContext context = tester.element(find.byType(FavoritosPage));
    ProviderScope.containerOf(context).read(favoritesProvider.notifier).toggle('bulbasaur');
    
    await tester.pumpAndSettle();

    // Verify Bulbasaur is shown (Capitalized by PokemonCard)
    expect(find.byType(SwipeableFavoriteItem), findsOneWidget);
    expect(find.text('Bulbasaur'), findsOneWidget);

    // Remove
    ProviderScope.containerOf(context).read(favoritesProvider.notifier).toggle('bulbasaur');
    await tester.pumpAndSettle();

    // Verify back to empty state
    expect(find.text('No has marcado ningún Pokémon como favorito'), findsOneWidget);
  });
}
