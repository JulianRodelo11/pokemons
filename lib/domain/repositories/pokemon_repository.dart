import 'package:pokemons/domain/entities/pokemon.dart';
import 'package:pokemons/domain/entities/pokemon_detail.dart';

/// Contrato del repositorio de Pokémon (capa domain).
abstract class PokemonRepository {
  Future<List<Pokemon>> getPokemonList();
  Future<PokemonDetail> getPokemonDetail(String name);
}
