import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokemons/core/theme/app_typography.dart';
import 'package:pokemons/core/theme/pokemon_type_colors.dart';
import 'package:pokemons/core/utils/pokemon_utils.dart';
import 'package:pokemons/core/utils/string_utils.dart';
import 'package:pokemons/domain/entities/pokemon_detail.dart';
import 'package:pokemons/l10n/app_localizations.dart';
import 'package:pokemons/presentation/providers/favorites_provider.dart';
import 'package:pokemons/presentation/providers/pokemon_detail_provider.dart';
import 'package:pokemons/presentation/screens/pokemon_detail/widgets/pokemon_gender_indicator.dart';
import 'package:pokemons/presentation/widgets/pokemon_attribute_card.dart';
import 'package:pokemons/presentation/widgets/pokemon_detail_header.dart';
import 'package:pokemons/presentation/widgets/pokemon_type_chip.dart';

/// Pantalla de detalle de un Pokémon.
class PokemonDetailScreen extends ConsumerWidget {
  const PokemonDetailScreen({
    super.key,
    required this.name,
    this.heroTagSuffix = 0,
  });
  final String name;
  final int heroTagSuffix;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = Localizations.localeOf(context).languageCode;
    final asyncDetail = ref.watch(
      pokemonDetailProvider(PokemonDetailKey(name: name, locale: locale)),
    );

    return Scaffold(
      body: asyncDetail.when(
        data: (PokemonDetail detail) =>
            _DetailBody(detail: detail, heroTagSuffix: heroTagSuffix),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (Object err, StackTrace? _) => Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.error_outline,
                  size: 48,
                  color: Theme.of(context).colorScheme.error,
                ),
                const SizedBox(height: 16),
                Text(
                  AppLocalizations.of(context)!.detailError(err.toString()),
                  textAlign: TextAlign.center,
                  style: AppTypography.bodyMedium,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _DetailBody extends ConsumerWidget {
  const _DetailBody({required this.detail, this.heroTagSuffix = 0});
  final PokemonDetail detail;
  final int heroTagSuffix;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final String locale = Localizations.localeOf(context).languageCode;

    final List<String> abilitiesList = PokemonUtils.abilitiesForLocale(
      detail.abilityNamesByLocale,
      detail.abilities,
      locale,
    );

    final List<String> abilitiesDisplay = abilitiesList
        .where((a) => a.trim().isNotEmpty)
        .map((a) => StringUtils.capitalize(a.trim()))
        .toList();

    final Color cardColor = PokemonTypeColors.cardBackground(detail.types);
    final bool isFavorite = ref.watch(favoritesProvider).contains(detail.name);
    final List<String> weaknesses = PokemonUtils.weaknessesForTypes(
      detail.types,
    );

    final String weightStr = PokemonUtils.formatMeasurement(detail.weight);
    final String heightStr = PokemonUtils.formatMeasurement(detail.height);

    return Stack(
      children: <Widget>[
        CustomScrollView(
          slivers: <Widget>[
            SliverToBoxAdapter(
              child: PokemonDetailHeader(
                detail: detail,
                cardColor: cardColor,
                drawCircle: true,
                heroTagSuffix: heroTagSuffix,
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                color: Colors.white,
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      StringUtils.capitalize(detail.name),
                      style: AppTypography.headingMedium.copyWith(
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      PokemonUtils.formatNumber(detail.id),
                      style: AppTypography.bodyMedium.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                    if (detail.types.isNotEmpty) ...[
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: detail.types
                            .map((t) => PokemonTypeChip(typeName: t))
                            .toList(),
                      ),
                    ],
                    const SizedBox(height: 16),
                    Text(
                      detail.description.isNotEmpty
                          ? detail.description
                          : 'Información no disponible.',
                      style: AppTypography.bodyMedium.copyWith(
                        color: Theme.of(context).colorScheme.onSurface,
                        height: 1.5,
                      ),
                    ),
                    Divider(
                      height: 32,
                      thickness: 1,
                      color: Theme.of(context).colorScheme.outlineVariant,
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: PokemonAttributeCard(
                            iconAssetPath: 'assets/svg/Peso.svg',
                            label: l10n.detailLabelPeso,
                            value: '$weightStr kg',
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: PokemonAttributeCard(
                            iconAssetPath: 'assets/svg/Altura.svg',
                            label: l10n.detailLabelAltura,
                            value: '$heightStr m',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: PokemonAttributeCard(
                            iconAssetPath: 'assets/svg/Categoria.svg',
                            label: l10n.detailLabelCategoria,
                            value: detail.category.isNotEmpty
                                ? detail.category
                                : '—',
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: PokemonAttributeCard(
                            iconAssetPath: 'assets/svg/Habilidad.svg',
                            label: l10n.detailLabelHabilidad,
                            value: abilitiesDisplay.isEmpty
                                ? '—'
                                : abilitiesDisplay.first,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    PokemonGenderIndicator(
                      maleRatio: detail.maleRatio,
                      femaleRatio: detail.femaleRatio,
                    ),
                    const SizedBox(height: 30),
                    Text(
                      l10n.detailDebilidades,
                      style: AppTypography.bodyMediumLg.copyWith(
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 12),
                    if (weaknesses.isNotEmpty)
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: weaknesses
                            .map((t) => PokemonTypeChip(typeName: t))
                            .toList(),
                      )
                    else
                      Text(
                        '—',
                        style: AppTypography.bodyMedium.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
        _buildTopBar(context, ref, isFavorite, detail.name, heroTagSuffix),
      ],
    );
  }

  Widget _buildTopBar(
    BuildContext context,
    WidgetRef ref,
    bool isFavorite,
    String pokemonName,
    int heroTagSuffix,
  ) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              _CircularIconButton(
                icon: Icons.chevron_left,
                onTap: () => Navigator.of(context).pop(),
              ),
              Hero(
                tag: 'pokemon-favorite-$pokemonName-$heroTagSuffix',
                child: _CircularIconButton(
                  icon: isFavorite ? Icons.favorite : Icons.favorite_border,
                  onTap: () =>
                      ref.read(favoritesProvider.notifier).toggle(pokemonName),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CircularIconButton extends StatelessWidget {
  const _CircularIconButton({required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white, width: 2),
          color: Colors.black.withValues(alpha: 0.2),
        ),
        alignment: Alignment.center,
        child: Icon(icon, color: Colors.white, size: 22),
      ),
    );
  }
}
