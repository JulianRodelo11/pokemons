import 'package:flutter/material.dart';

import 'package:pokemons/core/routes/app_routes.dart';
import 'package:pokemons/presentation/screens/home/home_screen.dart';
import 'package:pokemons/presentation/screens/onboarding/onboarding_screen.dart';
import 'package:pokemons/presentation/screens/pokemon_detail/pokemon_detail_screen.dart';
import 'package:pokemons/presentation/screens/splash/splash_screen.dart';

/// Genera la ruta correspondiente a [settings].
/// Concentra aquí toda la lógica de rutas y argumentos.
Route<dynamic>? generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case AppRoutes.splash:
      return MaterialPageRoute<void>(
        settings: settings,
        builder: (_) => const SplashScreen(),
      );
    case AppRoutes.onboarding:
      return MaterialPageRoute<void>(
        settings: settings,
        builder: (_) => const OnboardingScreen(),
      );
    case AppRoutes.home:
      return MaterialPageRoute<void>(
        settings: settings,
        builder: (_) => const HomeScreen(),
      );
    case AppRoutes.detail: {
      final args = settings.arguments;
      final String? name = args is Map
          ? args['name'] as String?
          : args is String
              ? args
              : null;
      final int heroTagSuffix = args is Map && args['heroTagSuffix'] != null
          ? args['heroTagSuffix'] as int
          : 0;
      if (name == null || name.isEmpty) {
        return MaterialPageRoute<void>(
          settings: const RouteSettings(name: AppRoutes.home),
          builder: (_) => const HomeScreen(),
        );
      }
      return MaterialPageRoute<void>(
        settings: settings,
        builder: (_) => PokemonDetailScreen(
          name: name,
          heroTagSuffix: heroTagSuffix,
        ),
      );
    }
    default:
      return MaterialPageRoute<void>(
        settings: settings,
        builder: (_) => const SplashScreen(),
      );
  }
}
