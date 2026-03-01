import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pokemons/core/theme/app_colors.dart';
import 'package:pokemons/core/theme/app_typography.dart';
import 'package:pokemons/core/theme/pokemon_type_colors.dart';
import 'package:pokemons/core/utils/pokemon_utils.dart';
import 'package:pokemons/core/utils/string_utils.dart';
import 'package:pokemons/domain/entities/pokemon_detail.dart';
import 'package:pokemons/l10n/app_localizations.dart';
import 'package:pokemons/presentation/providers/favorites_provider.dart';
import 'package:pokemons/presentation/providers/pokemon_detail_provider.dart';
import 'package:pokemons/presentation/widgets/pokemon_type_chip.dart';

/// Lista de habilidades según el idioma actual (abilityNamesByLocale[locale] ?? en ?? abilities).
List<String> _abilitiesForLocale(PokemonDetail detail, String locale) {
  if (detail.abilityNamesByLocale.isEmpty) return detail.abilities;
  return detail.abilityNamesByLocale[locale] ??
      detail.abilityNamesByLocale['en'] ??
      detail.abilities;
}

/// Pantalla de detalle de un Pokémon (diseño: header verde, datos, atributos, género, debilidades).
class PokemonDetailScreen extends ConsumerWidget {
  const PokemonDetailScreen({super.key, required this.name});
  final String name;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = Localizations.localeOf(context).languageCode;
    final asyncDetail = ref.watch(
      pokemonDetailProvider(PokemonDetailKey(name: name, locale: locale)),
    );

    return Scaffold(
      body: asyncDetail.when(
        data: (PokemonDetail detail) => _DetailBody(detail: detail),
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
  const _DetailBody({required this.detail});
  final PokemonDetail detail;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final String locale = Localizations.localeOf(context).languageCode;
    final List<String> abilitiesList = _abilitiesForLocale(detail, locale);
    final List<String> abilitiesDisplay = abilitiesList
        .where((a) => a.trim().isNotEmpty)
        .map((a) => StringUtils.capitalize(a.trim()))
        .toList();
    final Color cardColor = PokemonTypeColors.cardBackground(detail.types);
    final bool isFavorite = ref.watch(favoritesProvider).contains(detail.name);
    final List<String> weaknesses = PokemonUtils.weaknessesForTypes(
      detail.types,
    );
    final double weightKg = detail.weight / 10.0;
    final double heightM = detail.height / 10.0;
    final String weightStr = weightKg.toStringAsFixed(1).replaceAll('.', ',');
    final String heightStr = heightM.toStringAsFixed(1).replaceAll('.', ',');

    return Stack(
      children: <Widget>[
        CustomScrollView(
          slivers: <Widget>[
            SliverToBoxAdapter(
              child: _DetailHeader(
                detail: detail,
                cardColor: cardColor,
                drawCircle: true,
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
                      _descriptionFor(detail),
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
                          child: _AttributeCard(
                            iconAssetPath: 'assets/svg/Peso.svg',
                            label: l10n.detailLabelPeso,
                            value: '$weightStr kg',
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _AttributeCard(
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
                          child: _AttributeCard(
                            iconAssetPath: 'assets/svg/Categoria.svg',
                            label: l10n.detailLabelCategoria,
                            value: detail.category.isNotEmpty
                                ? detail.category
                                : '—',
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _AttributeCard(
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
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        l10n.detailLabelGenero,
                        style: AppTypography.labelMediumXs.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: LinearProgressIndicator(
                        value: detail.maleRatio ?? 0.5,
                        backgroundColor: AppColors.female,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          AppColors.male,
                        ),
                        minHeight: 8,
                      ),
                    ),
                    SizedBox(height: 6),
                    Row(
                      children: <Widget>[
                        Icon(Icons.male, size: 18, color: AppColors.male),
                        const SizedBox(width: 4),
                        Text(
                          detail.maleRatio != null
                              ? '${(detail.maleRatio! * 100).toStringAsFixed(1).replaceAll('.', ',')}%'
                              : '—',
                          style: AppTypography.bodyMedium,
                        ),
                        const Spacer(),
                        Icon(Icons.female, size: 18, color: AppColors.female),
                        const SizedBox(width: 4),
                        Text(
                          detail.femaleRatio != null
                              ? '${(detail.femaleRatio! * 100).toStringAsFixed(1).replaceAll('.', ',')}%'
                              : '—',
                          style: AppTypography.bodyMedium,
                        ),
                      ],
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
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                        color: Colors.black.withValues(alpha: 0.2),
                      ),
                      alignment: Alignment.center,
                      child: const Icon(
                        Icons.chevron_left,
                        color: Colors.white,
                        size: 22,
                      ),
                    ),
                  ),
                  Hero(
                    tag: 'pokemon-favorite-${detail.name}',
                    child: GestureDetector(
                      onTap: () => ref
                          .read(favoritesProvider.notifier)
                          .toggle(detail.name),
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
                          color: Colors.black.withValues(alpha: 0.2),
                        ),
                        alignment: Alignment.center,
                        child: Icon(
                          isFavorite ? Icons.favorite : Icons.favorite_border,
                          color: Colors.white,
                          size: 22,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  String _descriptionFor(PokemonDetail d) {
    if (d.description.isNotEmpty) return d.description;
    return 'Información no disponible.';
  }
}

/// Pinta un círculo completo. Radio elegido para que se vea la curva: el borde
/// inferior del header es el borde del círculo y la curva superior también se aprecia.
class _CircleBackgroundPainter extends CustomPainter {
  _CircleBackgroundPainter({required this.color});
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final double w = size.width;
    final double h = size.height;
    final double radius = (w * w * 0.25 + h * h) / (2 * h);
    final Offset center = Offset(w * 0.5, h - radius);

    // Recortar solo los lados (no arriba) para que se vea la curva superior del círculo
    canvas.save();
    final double paddingY = radius * 2;
    canvas.clipRect(Rect.fromLTWH(0, -paddingY, w, h + paddingY));

    canvas.drawCircle(center, radius, Paint()..color = color);

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _DetailHeader extends StatelessWidget {
  const _DetailHeader({
    required this.detail,
    required this.cardColor,
    this.drawCircle = false,
  });

  final PokemonDetail detail;
  final Color cardColor;
  final bool drawCircle;

  @override
  Widget build(BuildContext context) {
    final String? bgSvg = detail.types.isNotEmpty
        ? PokemonUtils.backgroundSvgPath(detail.types.first)
        : null;
    const double headerHeight = 300;

    final double width = MediaQuery.sizeOf(context).width;
    return Stack(
      clipBehavior: Clip.none,
      children: <Widget>[
        if (drawCircle)
          Hero(
            tag: 'pokemon-card-bg-${detail.name}',
            child: SizedBox(
              height: headerHeight,
              width: width,
              child: CustomPaint(
                painter: _CircleBackgroundPainter(color: cardColor),
                size: Size(width, headerHeight),
              ),
            ),
          ),
        if (bgSvg != null)
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: SizedBox(
              height: headerHeight,
              width: double.infinity,
              child: Center(
                child: Hero(
                  tag: 'pokemon-bg-svg-${detail.name}',
                  child: Opacity(
                    opacity: 0.35,
                    child: SvgPicture.asset(
                      bgSvg,
                      width: 204,
                      height: 204,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            ),
          ),
        Positioned(
          left: 0,
          right: 0,
          top: 40,
          child: Center(
            child: Hero(
              tag: 'pokemon-image-${detail.name}',
              child: detail.imageUrl.isNotEmpty
                  ? Image.network(
                      detail.imageUrl,
                      height: 320,
                      fit: BoxFit.contain,
                      errorBuilder: (BuildContext _, _, StackTrace? _) => Icon(
                        Icons.image_not_supported_rounded,
                        size: 120,
                        color: Colors.grey.shade400,
                      ),
                    )
                  : Icon(
                      Icons.image_not_supported_rounded,
                      size: 120,
                      color: Colors.grey.shade400,
                    ),
            ),
          ),
        ),
      ],
    );
  }
}

class _AttributeCard extends StatelessWidget {
  const _AttributeCard({
    required this.iconAssetPath,
    required this.label,
    required this.value,
  });

  final String iconAssetPath;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Row(
          children: <Widget>[
            SvgPicture.asset(
              iconAssetPath,
              width: 16,
              height: 16,
              colorFilter: ColorFilter.mode(Color(0xFF424242), BlendMode.srcIn),
            ),
            const SizedBox(width: 6),
            Text(
              label,
              style: AppTypography.bodyMedium.copyWith(
                fontSize: 11,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          height: 43,
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: Theme.of(context).colorScheme.outlineVariant,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(
              value,
              style: AppTypography.bodyMediumLg.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
