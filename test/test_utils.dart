import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokemons/l10n/app_localizations.dart';
import 'package:pokemons/presentation/providers/locale_provider.dart';

/// Un widget que envuelve el [child] con todo lo necesario para tests de UI.
class TestAppWrapper extends ConsumerWidget {
  const TestAppWrapper({
    super.key,
    required this.child,
    this.overrides = const [],
    this.navigatorKey,
  });

  final Widget child;
  final List<dynamic> overrides;
  final GlobalKey<NavigatorState>? navigatorKey;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = ref.watch(localeProvider);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      locale: locale,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      builder: (context, widget) {
        // Aseguramos que el builder tenga acceso a las localizaciones
        return Material(child: widget);
      },
      home: child,
    );
  }
}

/// Helper para crear el ProviderScope correctamente en tests
Widget createTestWidget({
  required Widget child,
  List<dynamic> overrides = const [],
  GlobalKey<NavigatorState>? navigatorKey,
}) {
  return ProviderScope(
    overrides: [...overrides],
    child: TestAppWrapper(
      navigatorKey: navigatorKey,
      overrides: overrides,
      child: child,
    ),
  );
}
