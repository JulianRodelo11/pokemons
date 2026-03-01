import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pokemons/core/theme/theme.dart';

class PokemonAttributeCard extends StatelessWidget {
  const PokemonAttributeCard({
    super.key,
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
              colorFilter: const ColorFilter.mode(
                AppColors.iconDefault,
                BlendMode.srcIn,
              ),
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
              color: AppColors.border,
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
