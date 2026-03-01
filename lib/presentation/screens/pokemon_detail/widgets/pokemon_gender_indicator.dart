import 'package:flutter/material.dart';
import 'package:pokemons/core/theme/app_colors.dart';
import 'package:pokemons/core/theme/app_typography.dart';
import 'package:pokemons/l10n/app_localizations.dart';

class PokemonGenderIndicator extends StatelessWidget {
  const PokemonGenderIndicator({
    super.key,
    required this.maleRatio,
    required this.femaleRatio,
  });

  final double? maleRatio;
  final double? femaleRatio;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    
    return Column(
      children: [
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
            value: maleRatio ?? 0.5,
            backgroundColor: AppColors.female,
            valueColor: const AlwaysStoppedAnimation<Color>(
              AppColors.male,
            ),
            minHeight: 8,
          ),
        ),
        const SizedBox(height: 6),
        Row(
          children: <Widget>[
            const Icon(Icons.male, size: 18, color: AppColors.male),
            const SizedBox(width: 4),
            Text(
              maleRatio != null
                  ? '${(maleRatio! * 100).toStringAsFixed(1).replaceAll('.', ',')}%'
                  : '—',
              style: AppTypography.bodyMedium,
            ),
            const Spacer(),
            const Icon(Icons.female, size: 18, color: AppColors.female),
            const SizedBox(width: 4),
            Text(
              femaleRatio != null
                  ? '${(femaleRatio! * 100).toStringAsFixed(1).replaceAll('.', ',')}%'
                  : '—',
              style: AppTypography.bodyMedium,
            ),
          ],
        ),
      ],
    );
  }
}
