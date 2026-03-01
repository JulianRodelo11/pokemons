import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
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

  bool _started = false;
  DateTime? _splashStart;
  late final Ticker _ticker;
  double _rotationValue = 0;

  @override
  void initState() {
    super.initState();
    _splashStart = DateTime.now();
    _ticker = createTicker((Duration elapsed) {
      if (_splashStart == null || !mounted) return;
      final int ms = DateTime.now().difference(_splashStart!).inMilliseconds;
      // Una rotación completa durante el tiempo que dura la pantalla
      final double progress = (ms / _splashDuration.inMilliseconds).clamp(
        0.0,
        1.0,
      );
      setState(
        () => _rotationValue = Curves.easeInOutCubic.transform(progress),
      );
    });
    _ticker.start();
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }

  Future<void> _loadAndGoToHome() async {
    if (_started) return;
    _started = true;
    await Future<void>.delayed(_splashDuration);
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
    if (!_started) {
      WidgetsBinding.instance.addPostFrameCallback(
        (Duration _) => _loadAndGoToHome(),
      );
    }
    return Scaffold(
      body: Center(
        child: Transform(
          alignment: Alignment.center,
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.001)
            ..rotateY(_rotationValue * 2 * math.pi),
          child: SvgPicture.asset(
            AssetsPaths.svgLoader,
            width: 155,
            height: 155,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
