import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokemons/core/constants/app_constants.dart';
import 'package:pokemons/core/di/injection.dart';
import 'package:pokemons/domain/entities/pokemon.dart';

/// Future de la lista; se puede invalidar para "Reintentar".
final pokemonListFutureProvider = FutureProvider<List<Pokemon>>((ref) async {
  final repository = ref.watch(pokemonRepositoryProvider);
  return repository.getPokemonList();
});

/// Lista de Pokémon. Si [forcePokemonListError] es true, devuelve error al instante (sin loading).
final pokemonListProvider = Provider<AsyncValue<List<Pokemon>>>((ref) {
  if (AppConstants.forcePokemonListError) {
    return AsyncValue.error(
      Exception('Error de prueba: lista forzada a fallar'),
      StackTrace.current,
    );
  }
  return ref.watch(pokemonListFutureProvider);
});

/// Notifier de tipos seleccionados en el filtro.
class SelectedFilterTypesNotifier extends Notifier<Set<String>> {
  @override
  Set<String> build() => <String>{};

  void setTypes(Set<String> types) {
    state = Set<String>.from(types);
  }

  void clear() {
    state = <String>{};
  }
}

/// Tipos seleccionados en el filtro (por tipo). Vacío = sin filtro por tipo.
final selectedFilterTypesProvider =
    NotifierProvider<SelectedFilterTypesNotifier, Set<String>>(
  SelectedFilterTypesNotifier.new,
);

/// Caché nombre → tipos para no volver a pedir el detalle cada vez que se aplica un filtro.
class PokemonTypesCacheNotifier extends Notifier<Map<String, List<String>>> {
  @override
  Map<String, List<String>> build() => <String, List<String>>{};

  void addAll(Map<String, List<String>> entries) {
    if (entries.isEmpty) return;
    state = Map<String, List<String>>.from(state)..addAll(entries);
  }
}

final pokemonTypesCacheProvider =
    NotifierProvider<PokemonTypesCacheNotifier, Map<String, List<String>>>(
  PokemonTypesCacheNotifier.new,
);

/// Lista filtrada por tipos. Si no hay tipos seleccionados devuelve la lista completa.
/// Usa [pokemonTypesCacheProvider]: la primera vez pide detalles y llena la caché; después es instantáneo.
final filteredByTypesPokemonListProvider =
    FutureProvider<List<Pokemon>>((ref) async {
  final list = await ref.watch(pokemonListFutureProvider.future);
  final selectedTypes = ref.watch(selectedFilterTypesProvider);
  if (selectedTypes.isEmpty) return list;

  final cache = ref.read(pokemonTypesCacheProvider);
  final cacheNotifier = ref.read(pokemonTypesCacheProvider.notifier);

  final List<String> missing = list
      .where((p) => !cache.containsKey(p.name))
      .map((p) => p.name)
      .toList();

  if (missing.isNotEmpty) {
    final repository = ref.read(pokemonRepositoryProvider);
    const int batchSize = 15;
    final Map<String, List<String>> newEntries = <String, List<String>>{};

    for (int i = 0; i < missing.length; i += batchSize) {
      final batch = missing.skip(i).take(batchSize).toList();
      final details = await Future.wait(
        batch.map((name) => repository.getPokemonDetail(name)),
      );
      for (int j = 0; j < batch.length; j++) {
        newEntries[batch[j]] = details[j].types;
      }
    }
    cacheNotifier.addAll(newEntries);
  }

  final updatedCache = ref.read(pokemonTypesCacheProvider);
  return list
      .where((p) {
        final types = updatedCache[p.name];
        if (types == null) return false;
        return types.any(
          (t) => selectedTypes.contains(t.toLowerCase()),
        );
      })
      .toList();
});
