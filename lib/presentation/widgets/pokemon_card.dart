import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pokemons/core/constants/app_constants.dart';
import 'package:pokemons/core/theme/theme.dart';
import 'package:pokemons/core/theme/pokemon_type_colors.dart';
import 'package:pokemons/core/utils/pokemon_utils.dart';
import 'package:pokemons/core/utils/string_utils.dart';
import 'package:pokemons/domain/entities/pokemon.dart';
import 'package:pokemons/domain/entities/pokemon_detail.dart';
import 'package:pokemons/presentation/providers/favorites_provider.dart';
import 'package:pokemons/presentation/providers/pokemon_detail_provider.dart';
import 'package:pokemons/presentation/providers/pokemon_list_provider.dart';
import 'package:pokemons/presentation/widgets/pokemon_background_svg.dart';
import 'package:pokemons/presentation/widgets/pokemon_type_chip.dart';

/// Carta de Pokémon en la lista (número, nombre, tipos, imagen, favorito).
/// [listIndex] es el índice en la lista (0-based).
/// El número mostrado (N°XXX) es el id del Pokémon extraído de la URL de la API (ej. .../pokemon/1/ → 1).
class PokemonCard extends ConsumerWidget {
  const PokemonCard({
    super.key,
    required this.pokemon,
    required this.listIndex,
    required this.onTap,
    this.displayNumber,
  });

  final Pokemon pokemon;
  final int listIndex;
  final VoidCallback onTap;
  /// Si se indica, se usa para mostrar N°XXX (p. ej. en favoritos).
  final int? displayNumber;

  /// Número a mostrar. Si displayNumber o pokemon.id es 0, en la rama [data] se usa detail.id.
  int get _number =>
      (displayNumber != null && displayNumber! > 0)
          ? displayNumber!
          : (pokemon.id > 0 ? pokemon.id : listIndex + 1);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Cargamos el detalle desde la lista porque la API de lista no devuelve la imagen;
    // de lo contrario esta petición se haría solo al entrar a la pantalla de detalle.
    final locale = Localizations.localeOf(context).languageCode;
    final AsyncValue<PokemonDetail> asyncDetail = ref.watch(
      pokemonDetailProvider(
        PokemonDetailKey(name: pokemon.name, locale: locale),
      ),
    );
    final Set<String> favorites = ref.watch(favoritesProvider);
    final bool isFavorite = favorites.contains(pokemon.name);

    return asyncDetail.when(
      data: (PokemonDetail detail) {
        if (!ref.read(pokemonTypesCacheProvider).containsKey(pokemon.name)) {
          final name = pokemon.name;
          final types = detail.types;
          Future.microtask(() {
            ref.read(pokemonTypesCacheProvider.notifier).addAll(
              <String, List<String>>{name: types},
            );
          });
        }
        final int effectiveId = pokemon.id > 0 ? pokemon.id : detail.id;
        return _buildCard(
          context,
          ref,
          types: detail.types,
          imageUrl: detail.imageUrl.isNotEmpty
              ? detail.imageUrl
              : PokemonUtils.officialArtworkUrl(effectiveId),
          isFavorite: isFavorite,
          number: (displayNumber != null && displayNumber! > 0)
              ? displayNumber!
              : (pokemon.id > 0 ? pokemon.id : detail.id),
        );
      },
      loading: () => _buildCardSkeleton(context),
      error: (Object err, StackTrace? stackTrace) =>
          _buildCardWithFallback(context, ref, isFavorite, _number),
    );
  }

  Widget _buildCard(
    BuildContext context,
    WidgetRef ref, {
    required List<String> types,
    required String imageUrl,
    required bool isFavorite,
    int? number,
  }) {
    final int num = number ?? _number;
    final Color cardColor = PokemonTypeColors.cardBackground(types);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          height: AppConstants.pokemonCardHeight,
          decoration: BoxDecoration(
            color: cardColor.withValues(alpha: 0.5),
            borderRadius: BorderRadius.circular(16),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Stack(
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 12,
                          top: 12,
                          bottom: 12,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(
                              PokemonUtils.formatNumber(num),
                              style: AppTypography.pokemonCardNumber.copyWith(
                                color: Theme.of(
                                  context,
                                ).colorScheme.onSurface.withValues(alpha: 0.8),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              StringUtils.capitalize(pokemon.name),
                              style: AppTypography.pokemonCardName,
                            ),
                            if (types.isNotEmpty) ...[
                              const SizedBox(height: 8),
                              Wrap(
                                spacing: 6,
                                runSpacing: 6,
                                children: types
                                    .map((t) => PokemonTypeChip(typeName: t))
                                    .toList(),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 126,
                      height: 102,
                      child: Stack(
                        children: <Widget>[
                          Positioned.fill(
                            child: Hero(
                              tag: 'pokemon-card-bg-${pokemon.name}-$listIndex',
                              child: Container(
                                decoration: BoxDecoration(
                                  color: cardColor,
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(16),
                                  ),
                                  border: Border.all(
                                    color: cardColor.withValues(alpha: 0.8),
                                    width: 1,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Positioned.fill(
                            child: Stack(
                              alignment: Alignment.center,
                              children: <Widget>[
                                Positioned.fill(
                                  child: _buildImageBackground(
                                    types,
                                    cardColor,
                                    pokemon.name,
                                    listIndex,
                                  ),
                                ),
                                Hero(
                                  tag:
                                      'pokemon-image-${pokemon.name}-$listIndex',
                                  child: Image.network(
                                    imageUrl,
                                    height: 88,
                                    width: 88,
                                    fit: BoxFit.contain,
                                    errorBuilder:
                                        (
                                          BuildContext context,
                                          error,
                                          stackTrace,
                                        ) => Icon(
                                          Icons.image_not_supported_rounded,
                                          size: 48,
                                          color: Theme.of(
                                            context,
                                          ).colorScheme.onSurfaceVariant,
                                        ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: IconButton(
                    style: IconButton.styleFrom(
                      splashFactory: NoSplash.splashFactory,
                    ),
                    icon: Hero(
                      tag: 'pokemon-favorite-${pokemon.name}-$listIndex',
                      child: _FavoriteHeartIcon(isFavorite: isFavorite),
                    ),
                    onPressed: () => ref
                        .read(favoritesProvider.notifier)
                        .toggle(pokemon.name),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Fondo detrás de la imagen: padding, medidas 94×91.37, SVG/círculo con degradé.
  /// Usa [PokemonBackgroundSvg] como hijo del Hero para que la animación muestre
  /// el mismo contenido (gradiente + SVG) en carta y detalle.
  Widget _buildImageBackground(
    List<String> types,
    Color cardColor,
    String pokemonName,
    int listIndex,
  ) {
    const double contentWidth = 94;
    const double contentHeight = 91.37;
    const EdgeInsets padding = EdgeInsets.all(6);

    final path = types.isNotEmpty
        ? PokemonUtils.backgroundSvgPath(types.first)
        : null;

    const double heroScale = 2.0;
    final double heroW = contentWidth * heroScale;
    final double heroH = contentHeight * heroScale;

    Widget shape;
    if (path != null) {
      shape = ClipRect(
        child: OverflowBox(
          maxWidth: heroW,
          maxHeight: heroH,
          alignment: Alignment.center,
          child: Transform.scale(
            scale: 1 / heroScale,
            alignment: Alignment.center,
            child: Hero(
              tag: 'pokemon-bg-svg-$pokemonName-$listIndex',
              child: PokemonBackgroundSvg(
                svgPath: path,
                width: heroW,
                height: heroH,
              ),
            ),
          ),
        ),
      );
    } else {
      shape = DecoratedBox(
        decoration: BoxDecoration(
          color: AppColors.white,
          shape: BoxShape.circle,
        ),
        child: const SizedBox.expand(),
      );
    }

    return Padding(
      padding: padding,
      child: SizedBox(width: contentWidth, height: contentHeight, child: shape),
    );
  }

  Widget _buildCardSkeleton(BuildContext context) {
    return Container(
      height: 102,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 60,
                  height: 12,
                  decoration: BoxDecoration(
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  width: 100,
                  height: 18,
                  decoration: BoxDecoration(
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 80,
            height: 80,
            child: Center(
              child: Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: Theme.of(
                    context,
                  ).colorScheme.onSurface.withValues(alpha: 0.12),
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCardWithFallback(
    BuildContext context,
    WidgetRef ref,
    bool isFavorite, [
    int? number,
  ]) {
    final int num = number ?? _number;
    final int idForImage = pokemon.id > 0 ? pokemon.id : num;
    final imageUrl = PokemonUtils.officialArtworkUrl(idForImage);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          height: 102,
          decoration: BoxDecoration(
            color: AppColors.cardFallback.withValues(alpha: 0.5),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: AppColors.cardFallback.withValues(alpha: 0.5),
              width: 1,
            ),
          ),
          child: Stack(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text(
                            PokemonUtils.formatNumber(num),
                            style: AppTypography.pokemonCardNumber,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            StringUtils.capitalize(pokemon.name),
                            style: AppTypography.pokemonCardName,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 100,
                      height: 100,
                      child: Hero(
                        tag: 'pokemon-image-${pokemon.name}-$listIndex',
                        child: Image.network(
                          imageUrl,
                          height: 88,
                          width: 88,
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) =>
                              const Icon(
                                Icons.image_not_supported_rounded,
                                size: 48,
                              ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 12,
                right: 12,
                child: IconButton(
                  style: IconButton.styleFrom(
                    splashFactory: NoSplash.splashFactory,
                  ),
                  icon: Hero(
                    tag: 'pokemon-favorite-${pokemon.name}-$listIndex',
                    child: _FavoriteHeartIcon(isFavorite: isFavorite),
                  ),
                  onPressed: () =>
                      ref.read(favoritesProvider.notifier).toggle(pokemon.name),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Icono de favorito: [Heart.svg] (outline) o [HeartSolid.svg] (relleno). Color blanco y borde blanco.
class _FavoriteHeartIcon extends StatelessWidget {
  const _FavoriteHeartIcon({required this.isFavorite});

  static const double _size = 16.0;
  static const double _borderWidth = 2.0;

  final bool isFavorite;

  @override
  Widget build(BuildContext context) {
    final path = isFavorite
        ? 'assets/svg/HeartSolid.svg'
        : 'assets/svg/Heart.svg';
    return Container(
      width: _size * 2,
      height: _size * 2,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.white, width: _borderWidth),
        color: Colors.black.withValues(alpha: 0.3),
      ),
      alignment: Alignment.center,
      child: SizedBox(
        width: _size,
        height: _size,
        child: SvgPicture.asset(
          path,
          width: _size,
          height: _size,
          colorFilter: const ColorFilter.mode(AppColors.white, BlendMode.srcIn),
        ),
      ),
    );
  }
}
