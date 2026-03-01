import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Notifier que mantiene el conjunto de nombres de Pokémon favoritos.
class FavoritesNotifier extends Notifier<Set<String>> {
  @override
  Set<String> build() => <String>{};

  void toggle(String name) {
    final next = Set<String>.from(state);
    if (next.contains(name)) {
      next.remove(name);
    } else {
      next.add(name);
    }
    state = next;
  }
}

/// Provider de favoritos.
final favoritesProvider = NotifierProvider<FavoritesNotifier, Set<String>>(FavoritesNotifier.new);
