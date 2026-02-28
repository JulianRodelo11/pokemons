import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:pokemons/core/navigation/navigation_service.dart';

/// Clave del [Navigator]. Debe hacerse override en [main] con la clave
/// usada por [MaterialApp].
final navigatorKeyProvider = Provider<GlobalKey<NavigatorState>>(
  (ref) => throw StateError(
    'navigatorKeyProvider must be overridden in main() with the MaterialApp key',
  ),
);

/// Servicio de navegación. Disponible en toda la app vía [ref.read].
final navigationServiceProvider = Provider<NavigationService>((ref) {
  return NavigationService(ref.watch(navigatorKeyProvider));
});
