import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokemons/core/routes/app_routes.dart';
import 'package:pokemons/core/theme/app_typography.dart';
import 'package:pokemons/domain/entities/pokemon.dart';
import 'package:pokemons/l10n/app_localizations.dart';
import 'package:pokemons/presentation/providers/favorites_provider.dart';
import 'package:pokemons/presentation/providers/pokemon_list_provider.dart';
import 'package:pokemons/presentation/widgets/swipeable_favorite_item.dart';

class FavoritosPage extends ConsumerWidget {
  const FavoritosPage({super.key});

  void _openDetail(BuildContext context, String name, int listIndex) {
    Navigator.of(context).pushNamed(
      AppRoutes.detail,
      arguments: <String, dynamic>{'name': name, 'heroTagSuffix': listIndex},
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AppLocalizations l10n = AppLocalizations.of(context)!;
    final asyncList = ref.watch(pokemonListProvider);
    final Set<String> favorites = ref.watch(favoritesProvider);

    return asyncList.when(
      data: (List<Pokemon> list) {
        final List<Pokemon> favoritePokemons = list
            .where((p) => favorites.contains(p.name))
            .toList();
        if (favoritePokemons.isEmpty) {
          return _buildFavoritosEmptyState(context, l10n);
        }
        return ListView.builder(
          padding: const EdgeInsets.only(
            left: 16,
            right: 16,
            top: 16,
            bottom: 32,
          ),
          itemCount: favoritePokemons.length,
          itemBuilder: (context, int index) {
            final pokemon = favoritePokemons[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return SwipeableFavoriteItem(
                    key: Key(pokemon.name),
                    maxWidth: constraints.maxWidth,
                    pokemon: pokemon,
                    listIndex: pokemon.id - 1,
                    displayNumber: pokemon.id > 0 ? pokemon.id : null,
                    onTap: () => _openDetail(context, pokemon.name, pokemon.id - 1),
                    onDismiss: () => ref
                        .read(favoritesProvider.notifier)
                        .toggle(pokemon.name),
                  );
                },
              ),
            );
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (_, _) => _buildFavoritosEmptyState(context, l10n),
    );
  }

  Widget _buildFavoritosEmptyState(
    BuildContext context,
    AppLocalizations l10n,
  ) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/images/3.0x/Magikarp_Jump_Pattern_01_1.png',
              height: 200,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) => Icon(
                Icons.image_not_supported_outlined,
                size: 80,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              l10n.favoritesEmptyTitle,
              textAlign: TextAlign.center,
              style: AppTypography.headingMedium.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              l10n.favoritesEmptySubtitle,
              textAlign: TextAlign.center,
              style: AppTypography.bodyMedium.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
