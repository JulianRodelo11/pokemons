import 'package:flutter/material.dart';

import 'package:pokemons/core/theme/app_colors.dart';
import 'package:pokemons/core/theme/app_typography.dart';
import 'package:pokemons/core/theme/sweep_splash.dart';

/// Tema de la aplicación. Material 3 generado desde [AppColors.primary].
abstract class AppTheme {
  AppTheme._();

  static ThemeData get light {
    final ColorScheme colorScheme = ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      primary: AppColors.primary,
      brightness: Brightness.light,
    );
    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: Colors.white,
      splashFactory: const SweepSplashFactory(),
      appBarTheme: AppBarTheme(
        centerTitle: true,
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        color: colorScheme.surfaceContainerHighest,
      ),
      listTileTheme: ListTileThemeData(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: ButtonStyle(
          minimumSize: WidgetStateProperty.all(const Size(0, 58)),
          backgroundColor: WidgetStateProperty.all(colorScheme.primary),
          foregroundColor: WidgetStateProperty.all(colorScheme.onPrimary),
          textStyle: WidgetStateProperty.all(AppTypography.buttonLabel),
          overlayColor: WidgetStateProperty.all(
            Color.lerp(
              colorScheme.primary,
              Colors.white,
              0.2,
            )!.withValues(alpha: 0.35),
          ),
        ),
      ),
    );
  }
}
