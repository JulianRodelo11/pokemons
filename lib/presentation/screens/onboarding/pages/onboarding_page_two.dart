import 'package:flutter/material.dart';
import 'package:pokemons/core/constants/assets_paths.dart';
import 'package:pokemons/core/theme/app_typography.dart';
import 'package:pokemons/l10n/app_localizations.dart';

class OnboardingPageTwo extends StatelessWidget {
  const OnboardingPageTwo({super.key});

  @override
  Widget build(BuildContext context) {
    final double availableWidth = MediaQuery.sizeOf(context).width - 150;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            AssetsPaths.imageOnboarding02,
            width: availableWidth,
            fit: BoxFit.contain,
            filterQuality: FilterQuality.high,
            errorBuilder:
                (BuildContext _, Object error, StackTrace? stackTrace) => Icon(
                  Icons.image_not_supported_outlined,
                  size: 120,
                  color: Theme.of(context).colorScheme.outline,
                ),
          ),
          const SizedBox(height: 32),
          Text(
            AppLocalizations.of(context)!.onboardingFavoritesTitle,
            style: AppTypography.headingMedium.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            AppLocalizations.of(context)!.onboardingFavoritesSubtitle,
            style: AppTypography.bodyMedium.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
