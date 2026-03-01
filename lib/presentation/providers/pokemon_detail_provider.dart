import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokemons/core/di/injection.dart';
import 'package:pokemons/domain/entities/pokemon_detail.dart';

/// Argumentos para abrir la pantalla de detalle.
class PokemonDetailArgs {
  const PokemonDetailArgs({required this.name});
  final String name;
}

/// Clave (nombre + locale) para cachear el detalle por idioma.
/// Así la categoría (género) se muestra en el idioma de la app.
class PokemonDetailKey {
  const PokemonDetailKey({required this.name, required this.locale});
  final String name;
  final String locale;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PokemonDetailKey &&
          name == other.name &&
          locale == other.locale;

  @override
  int get hashCode => Object.hash(name, locale);
}

/// Detalle de un Pokémon por nombre.
/// Sin autoDispose para que, al hacer scroll y volver, no se vuelva a cargar
/// el detalle ni las imágenes.
/// Requiere [PokemonDetailKey] con el locale de la app para que la categoría
/// (género) se muestre en el idioma correcto.
final pokemonDetailProvider =
    FutureProvider.family<PokemonDetail, PokemonDetailKey>((ref, key) async {
  final repository = ref.watch(pokemonRepositoryProvider);
  return repository.getPokemonDetail(key.name, locale: key.locale);
});
