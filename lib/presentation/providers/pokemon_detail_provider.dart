import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokemons/core/di/injection.dart';
import 'package:pokemons/domain/entities/pokemon_detail.dart';

/// Argumentos para abrir la pantalla de detalle.
class PokemonDetailArgs {
  const PokemonDetailArgs({required this.name});
  final String name;
}

/// Detalle de un Pokémon por nombre.
final pokemonDetailProvider =
    FutureProvider.autoDispose.family<PokemonDetail, String>((ref, name) async {
  final repository = ref.watch(pokemonRepositoryProvider);
  return repository.getPokemonDetail(name);
});
