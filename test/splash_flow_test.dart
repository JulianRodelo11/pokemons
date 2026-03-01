import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokemons/core/navigation/navigation_providers.dart';
import 'package:pokemons/core/navigation/navigation_service.dart';
import 'package:pokemons/presentation/screens/splash/splash_screen.dart';
import 'package:pokemons/presentation/screens/onboarding/onboarding_screen.dart';
import 'test_utils.dart';

class MockNavigationService extends NavigationService {
  MockNavigationService(super.navigatorKey);

  bool navigateCalled = false;
  Widget? navigatedTo;

  @override
  Future<T?> navigate<T>(
    Widget widget, {
    AnimationType animationType = AnimationType.slideRight,
    Duration duration = const Duration(milliseconds: 300),
    Curve curve = Curves.easeInOut,
  }) async {
    navigateCalled = true;
    navigatedTo = widget;
    return null;
  }
}

void main() {
  testWidgets('SplashScreen navigates to Onboarding after duration',
      (WidgetTester tester) async {
    final navigatorKey = GlobalKey<NavigatorState>();
    final mockNav = MockNavigationService(navigatorKey);

    await tester.pumpWidget(
      createTestWidget(
        overrides: [
          navigationServiceProvider.overrideWithValue(mockNav),
        ],
        child: const SplashScreen(),
      ),
    );

    // Verify loader is present
    expect(find.byType(SplashScreen), findsOneWidget);

    // Advance time by splash duration (1500ms)
    // Use pump repeatedly instead of pumpAndSettle to avoid Ticker timeout
    for (int i = 0; i < 16; i++) {
      await tester.pump(const Duration(milliseconds: 100));
    }

    expect(mockNav.navigateCalled, isTrue);
    expect(mockNav.navigatedTo, isA<OnboardingScreen>());
  });
}
