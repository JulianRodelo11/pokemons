import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:pokemons/core/constants/assets_paths.dart';
import 'package:pokemons/core/navigation/navigation_providers.dart';
import 'package:pokemons/core/routes/app_routes.dart';
import 'package:pokemons/l10n/app_localizations.dart';

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

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _next() {
    if (_currentPage < _totalPages - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      setState(() => _currentPage++);
    } else {
      // Reemplaza toda la pila: solo queda Home.
      ref
          .read(navigationServiceProvider)
          .navigateAndRemoveUntil<void>(AppRoutes.home);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                onPageChanged: (int index) =>
                    setState(() => _currentPage = index),
                children: [_OnboardingPage1(), _OnboardingPage2()],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (_currentPage > 0)
                    TextButton(
                      onPressed: () {
                        _pageController.previousPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                        setState(() => _currentPage--);
                      },
                      child: Text(AppLocalizations.of(context)!.onboardingBack),
                    )
                  else
                    const SizedBox.shrink(),
                  FilledButton(
                    onPressed: _next,
                    child: Text(
                      _currentPage < _totalPages - 1
                          ? AppLocalizations.of(context)!.onboardingNext
                          : AppLocalizations.of(context)!.onboardingStart,
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                _totalPages,
                (int index) => Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentPage == index
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(
                            context,
                          ).colorScheme.outline.withValues(alpha: 0.3),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

class _OnboardingPage1 extends StatelessWidget {
  const _OnboardingPage1();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            AssetsPaths.imageOnboarding01,
            width: 280,
            height: 280,
            fit: BoxFit.contain,
            errorBuilder: (_, Object error, StackTrace? stackTrace) => Icon(
              Icons.image_not_supported_outlined,
              size: 120,
              color: Theme.of(context).colorScheme.outline,
            ),
          ),
          const SizedBox(height: 32),
          Text(
            AppLocalizations.of(context)!.onboardingWelcomeTitle,
            style: Theme.of(
              context,
            ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            AppLocalizations.of(context)!.onboardingWelcomeSubtitle,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _OnboardingPage2 extends StatelessWidget {
  const _OnboardingPage2();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            AssetsPaths.imageOnboarding02,
            width: 280,
            height: 280,
            fit: BoxFit.contain,
            errorBuilder: (_, Object error, StackTrace? stackTrace) => Icon(
              Icons.image_not_supported_outlined,
              size: 120,
              color: Theme.of(context).colorScheme.outline,
            ),
          ),
          const SizedBox(height: 32),
          Text(
            AppLocalizations.of(context)!.onboardingFavoritesTitle,
            style: Theme.of(
              context,
            ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            AppLocalizations.of(context)!.onboardingFavoritesSubtitle,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
