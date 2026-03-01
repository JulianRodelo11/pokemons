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
