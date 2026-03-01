import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokemons/core/navigation/navigation_providers.dart';
import 'package:pokemons/core/navigation/navigation_service.dart';
import 'package:pokemons/core/routes/app_routes.dart';
import 'package:pokemons/presentation/screens/onboarding/onboarding_screen.dart';
import 'package:pokemons/core/widgets/sweep_button.dart';
import 'test_utils.dart';

class MockNavigationOnboarding extends NavigationService {
  MockNavigationOnboarding(super.navigatorKey);

  String? navigatedRoute;

  @override
  Future<T?> navigateAndRemoveUntil<T>(
    String routeName, {
    Object? arguments,
  }) async {
    navigatedRoute = routeName;
    return null;
  }
}

void main() {
  testWidgets('Onboarding flow: navigate to Home after two pages', (
    WidgetTester tester,
  ) async {
    final navigatorKey = GlobalKey<NavigatorState>();
    final mockNav = MockNavigationOnboarding(navigatorKey);

    await tester.pumpWidget(
      createTestWidget(
        overrides: [navigationServiceProvider.overrideWithValue(mockNav)],
        child: const OnboardingScreen(),
      ),
    );

    // Tap Continue
    await tester.tap(find.byType(SweepButton));
    await tester.pumpAndSettle();

    // Now on Page 2, button should say "Empecemos" (Let's start)
    expect(find.text('Empecemos'), findsOneWidget);

    // Tap Start
    await tester.tap(find.byType(SweepButton));
    await tester.pumpAndSettle();

    expect(mockNav.navigatedRoute, AppRoutes.home);
  });
}
