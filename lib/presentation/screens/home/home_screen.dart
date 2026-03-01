import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokemons/core/routes/app_routes.dart';
import 'package:pokemons/core/theme/app_typography.dart';
import 'package:pokemons/domain/entities/pokemon.dart';
import 'package:pokemons/l10n/app_localizations.dart';
import 'package:pokemons/presentation/providers/favorites_provider.dart';
import 'package:pokemons/presentation/providers/pokemon_list_provider.dart';
import 'package:pokemons/presentation/widgets/home_bottom_nav.dart';
import 'package:pokemons/presentation/widgets/home_search_bar.dart';
import 'package:pokemons/presentation/widgets/pokemon_card.dart';

/// Pantalla principal: búsqueda, lista de cartas de Pokémon y bottom nav.
class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  int _selectedNavIndex = 0;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(
        () => _searchQuery = _searchController.text.trim().toLowerCase(),
      );
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context)!;
    return Scaffold(
      body: SafeArea(
        child: _selectedNavIndex == 0
            ? _buildPokedexTab(context, l10n)
            : _selectedNavIndex == 1
            ? _buildRegionesTab(context, l10n)
            : _selectedNavIndex == 2
            ? _buildFavoritosTab(context, l10n)
            : _buildPlaceholderTab(context),
      ),
      bottomNavigationBar: HomeBottomNav(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            HomeNavItem(
              svgAsset: 'assets/svg/house.svg',
              label: l10n.navPokedex,
              selected: _selectedNavIndex == 0,
              onTap: () => setState(() => _selectedNavIndex = 0),
            ),
            HomeNavItem(
              svgAsset: 'assets/svg/globe.svg',
              label: l10n.navRegiones,
              selected: _selectedNavIndex == 1,
              onTap: () => setState(() => _selectedNavIndex = 1),
            ),
            HomeNavItem(
              svgAsset: 'assets/svg/heart.fill.svg',
              label: l10n.navFavoritos,
              selected: _selectedNavIndex == 2,
              onTap: () => setState(() => _selectedNavIndex = 2),
            ),
            HomeNavItem(
              svgAsset: 'assets/svg/user.svg',
              label: l10n.navPerfil,
              selected: _selectedNavIndex == 3,
              onTap: () => setState(() => _selectedNavIndex = 3),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPokedexTab(BuildContext context, AppLocalizations l10n) {
    final asyncList = ref.watch(pokemonListProvider);
    return asyncList.when(
      data: (List<Pokemon> list) {
        final List<Pokemon> filtered = list
            .where((p) => p.name.toLowerCase().contains(_searchQuery))
            .toList();
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const SizedBox(height: 16),
            HomeSearchBar(
              controller: _searchController,
              hint: l10n.homeSearchHint,
            ),
            const SizedBox(height: 16),
            Expanded(
              child: filtered.isEmpty
                  ? Center(child: Text(l10n.homeEmptyList))
                  : ListView.builder(
                      padding: const EdgeInsets.only(
                        left: 16,
                        right: 16,
                        top: 8,
                        bottom: 32,
                      ),
                      itemCount: filtered.length,
                      itemBuilder: (context, index) {
                        final pokemon = filtered[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: PokemonCard(
                            pokemon: pokemon,
                            listIndex: index,
                            onTap: () => _openDetail(context, pokemon.name),
                          ),
                        );
                      },
                    ),
            ),
          ],
        );
      },
      loading: () => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const SizedBox(height: 16),
          HomeSearchBar(
            controller: _searchController,
            hint: l10n.homeSearchHint,
          ),
        ],
      ),
      error: (Object err, StackTrace? stackTrace) => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const SizedBox(height: 16),
          Expanded(
            child: Center(
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
                        Icons.error_outline,
                        size: 80,
                        color: Theme.of(context).colorScheme.error,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      l10n.homeErrorTitle,
                      textAlign: TextAlign.center,
                      style: AppTypography.headingMedium.copyWith(
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      l10n.homeErrorDescription,
                      textAlign: TextAlign.center,

                      style: AppTypography.bodyMedium.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton(
                        onPressed: () {
                          ref.invalidate(pokemonListFutureProvider);
                          ref.invalidate(pokemonListProvider);
                        },
                        child: Text(l10n.homeErrorRetry),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRegionesTab(BuildContext context, AppLocalizations l10n) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/images/3.0x/Magikarp_Jump_Pattern_01_2.png',
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
              l10n.regionsComingSoonTitle,
              textAlign: TextAlign.center,
              style: AppTypography.headingMedium.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              l10n.regionsComingSoonDescription,
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

  Widget _buildFavoritosTab(BuildContext context, AppLocalizations l10n) {
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
                  return _SwipeableFavoriteItem(
                    key: Key(pokemon.name),
                    maxWidth: constraints.maxWidth,
                    pokemon: pokemon,
                    listIndex: pokemon.id - 1,
                    onTap: () => _openDetail(context, pokemon.name),
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

  Widget _buildPlaceholderTab(BuildContext context) {
    return Center(
      child: Text(
        AppLocalizations.of(context)!.navPokedex,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
          color: Theme.of(context).colorScheme.onSurfaceVariant,
        ),
      ),
    );
  }

  void _openDetail(BuildContext context, String name) {
    Navigator.of(context).pushNamed(AppRoutes.detail, arguments: name);
  }
}

const double _kDeleteStripMinWidth = 126;
const double _kCardHeight = 102;

/// Porcentaje del ancho que debe deslizarse para eliminar (0.25 = 25%).
const double _kDismissThresholdFraction = 0.25;
const Duration _kSnapBackDuration = Duration(milliseconds: 300);

class _SwipeableFavoriteItem extends StatefulWidget {
  const _SwipeableFavoriteItem({
    super.key,
    required this.maxWidth,
    required this.pokemon,
    required this.listIndex,
    required this.onTap,
    required this.onDismiss,
  });

  final double maxWidth;
  final Pokemon pokemon;
  final int listIndex;
  final VoidCallback onTap;
  final VoidCallback onDismiss;

  @override
  State<_SwipeableFavoriteItem> createState() => _SwipeableFavoriteItemState();
}

class _SwipeableFavoriteItemState extends State<_SwipeableFavoriteItem>
    with SingleTickerProviderStateMixin {
  double _dragOffset = 0;
  double _snapBackFrom = 0;
  late final AnimationController _snapBackController;

  @override
  void initState() {
    super.initState();
    _snapBackController = AnimationController(
      vsync: this,
      duration: _kSnapBackDuration,
    );
  }

  @override
  void dispose() {
    _snapBackController.dispose();
    super.dispose();
  }

  double get _dismissThreshold => widget.maxWidth * _kDismissThresholdFraction;

  void _onHorizontalDragUpdate(DragUpdateDetails details) {
    if (_snapBackController.isAnimating) {
      _snapBackController.removeListener(_onSnapBackTick);
      _snapBackController.reset();
    }
    setState(() {
      _dragOffset = (_dragOffset - details.delta.dx).clamp(
        0.0,
        widget.maxWidth,
      );
    });
  }

  void _onHorizontalDragEnd(DragEndDetails details) {
    if (_dragOffset >= _dismissThreshold) {
      widget.onDismiss();
    } else {
      _snapBackFrom = _dragOffset;
      _snapBackController.forward(from: 0);
      _snapBackController.addListener(_onSnapBackTick);
    }
  }

  void _onSnapBackTick() {
    final t = Curves.easeOut.transform(_snapBackController.value);
    setState(() => _dragOffset = _snapBackFrom * (1 - t));
    if (_snapBackController.isCompleted) {
      _snapBackController.removeListener(_onSnapBackTick);
      _snapBackController.reset();
      setState(() => _dragOffset = 0);
    }
  }

  @override
  Widget build(BuildContext context) {
    final double redWidth = (_kDeleteStripMinWidth + _dragOffset).clamp(
      _kDeleteStripMinWidth,
      widget.maxWidth,
    );

    return Stack(
      clipBehavior: Clip.none,
      children: <Widget>[
        Positioned(
          top: 0,
          right: 0,
          width: redWidth,
          height: _kCardHeight,
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xFFCD3131),
              borderRadius: BorderRadius.circular(16),
            ),
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.only(right: 20),
            child: const Icon(
              Icons.delete_outline,
              color: Colors.white,
              size: 28,
            ),
          ),
        ),
        GestureDetector(
          onHorizontalDragUpdate: _onHorizontalDragUpdate,
          onHorizontalDragEnd: _onHorizontalDragEnd,
          child: Transform.translate(
            offset: Offset(-_dragOffset, 0),
            child: PokemonCard(
              pokemon: widget.pokemon,
              listIndex: widget.listIndex,
              onTap: widget.onTap,
            ),
          ),
        ),
      ],
    );
  }
}
