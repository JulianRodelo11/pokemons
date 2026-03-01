import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:pokemons/core/constants/app_constants.dart';
import 'package:pokemons/core/constants/assets_paths.dart';
import 'package:pokemons/core/navigation/navigation_providers.dart';
import 'package:pokemons/core/navigation/navigation_service.dart';
import 'package:pokemons/presentation/screens/onboarding/onboarding_screen.dart';

/// Pantalla de splash. Espera solo el tiempo mínimo y navega a Onboarding con fade.
class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen>
    with SingleTickerProviderStateMixin {
  Duration get _splashDuration => AppConstants.forcePokemonListError
      ? AppConstants.splashFadeDuration
      : AppConstants.splashDuration;

  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: _splashDuration);

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOutCubic,
    );

    _controller.forward().then((_) => _goToNext());
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _goToNext() {
    if (!mounted) return;
    ref
        .read(navigationServiceProvider)
        .navigate<void>(
          const OnboardingScreen(),
          animationType: AnimationType.fade,
          duration: AppConstants.splashFadeDuration,
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.001)
                ..rotateY(_animation.value * 6 * math.pi),
              child: child,
            );
          },
          child: SvgPicture.asset(
            AssetsPaths.svgLoader,
            width: 120,
            height: 120,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
