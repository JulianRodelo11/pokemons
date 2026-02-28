import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:pokemons/core/navigation/navigation_providers.dart';
import 'package:pokemons/core/routes/app_routes.dart';
import 'package:pokemons/core/routes/app_router.dart';
import 'package:pokemons/core/theme/theme.dart';
import 'package:pokemons/l10n/app_localizations.dart';

void main() {
  final navigatorKey = GlobalKey<NavigatorState>();
  runApp(
    ProviderScope(
      overrides: [
        navigatorKeyProvider.overrideWithValue(navigatorKey),
      ],
      child: MainApp(navigatorKey: navigatorKey),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key, required this.navigatorKey});
  final GlobalKey<NavigatorState> navigatorKey;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      onGenerateTitle: (BuildContext context) =>
          AppLocalizations.of(context)!.appTitle,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      initialRoute: AppRoutes.splash,
      onGenerateRoute: generateRoute,
    );
  }
}
