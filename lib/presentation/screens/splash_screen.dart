import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:pokemons/core/constants/assets_paths.dart';
import 'package:pokemons/core/navigation/navigation_providers.dart';
import 'package:pokemons/core/navigation/navigation_service.dart';
import 'package:pokemons/domain/entities/pokemon.dart';
import 'package:pokemons/l10n/app_localizations.dart';
import 'package:pokemons/presentation/providers/pokemon_list_provider.dart';
import 'package:pokemons/presentation/screens/onboarding_screen.dart';

/// Pantalla de splash. Carga la lista y al terminar navega a Onboarding con fade.
class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  bool _started = false;

  Future<void> _loadAndGoToHome() async {
    if (_started) return;
    _started = true;
    // Prefetch: cuando termine (o falle), los datos quedan en caché para Home.
    await ref.read(pokemonListProvider.future).catchError((_) => <Pokemon>[]);
    if (!mounted) return;
    ref.read(navigationServiceProvider).navigate<void>(
          const OnboardingScreen(),
          animationType: AnimationType.fade,
          duration: const Duration(milliseconds: 400),
        );
  }

  @override
  Widget build(BuildContext context) {
    if (!_started) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _loadAndGoToHome());
    }
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              AppLocalizations.of(context)!.splashTitle,
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 48),
            SvgPicture.asset(
              AssetsPaths.svgLoader,
              width: 120,
              height: 120,
              fit: BoxFit.contain,
            ),
          ],
        ),
      ),
    );
  }
}
