import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokemons/core/di/injection.dart';
import 'package:pokemons/domain/entities/pokemon.dart';

/// Lista de Pokémon desde la API.
/// Sin autoDispose para que el prefetch del splash deje los datos en caché para Home.
final pokemonListProvider = FutureProvider<List<Pokemon>>((ref) async {
  final repository = ref.watch(pokemonRepositoryProvider);
  return repository.getPokemonList();
});
