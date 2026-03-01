import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:pokemons/core/navigation/navigation_providers.dart';
import 'package:pokemons/core/routes/app_routes.dart';
import 'package:pokemons/core/widgets/sweep_button.dart';
import 'package:pokemons/l10n/app_localizations.dart';
import 'package:pokemons/presentation/screens/onboarding/pages/onboarding_page_one.dart';
import 'package:pokemons/presentation/widgets/three_dot_loading.dart';
import 'package:pokemons/presentation/screens/onboarding/pages/onboarding_page_two.dart';
import 'package:pokemons/presentation/widgets/onboarding_page_indicator.dart';

/// Onboarding: una pantalla con dos ventanas (pasos). Al terminar va a Home.
class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  static const int _totalPages = 2;
  bool _isLoading = false;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onTapDown() {
    if (_isLoading) return;
    setState(() => _isLoading = true);
  }

  Future<void> _next() async {
    if (mounted) setState(() => _isLoading = false);
    if (_currentPage < _totalPages - 1) {
      await _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      await ref
          .read(navigationServiceProvider)
          .navigateAndRemoveUntil<void>(AppRoutes.home);
    }
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context)!;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (int index) =>
                    setState(() => _currentPage = index),
                children: const [OnboardingPageOne(), OnboardingPageTwo()],
              ),
            ),
            OnboardingPageIndicator(
              currentPage: _currentPage,
              totalPages: _totalPages,
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
              child: SizedBox(
                width: double.infinity,
                height: 58,
                child: SweepButton(
                  onPressed: _next,
                  onTapDown: _onTapDown,
                  child: _isLoading
                      ? const ThreeDotLoading(
                          color: Colors.white,
                          size: 10,
                          spacing: 8,
                        )
                      : Text(
                          _currentPage < _totalPages - 1
                              ? l10n.onboardingContinue
                              : l10n.onboardingStart,
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
