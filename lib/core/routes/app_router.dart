import 'package:flutter/material.dart';

import 'package:pokemons/core/routes/app_routes.dart';
import 'package:pokemons/presentation/screens/home_screen.dart';
import 'package:pokemons/presentation/screens/onboarding_screen.dart';
import 'package:pokemons/presentation/screens/pokemon_detail_screen.dart';
import 'package:pokemons/presentation/screens/splash_screen.dart';

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
    case AppRoutes.detail:
      final name = settings.arguments as String?;
      if (name == null || name.isEmpty) {
        return MaterialPageRoute<void>(
          settings: const RouteSettings(name: AppRoutes.home),
          builder: (_) => const HomeScreen(),
        );
      }
      return MaterialPageRoute<void>(
        settings: settings,
        builder: (_) => PokemonDetailScreen(name: name),
      );
    default:
      return MaterialPageRoute<void>(
        settings: settings,
        builder: (_) => const SplashScreen(),
      );
  }
}
