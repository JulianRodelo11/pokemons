import 'package:pokemons/data/datasources/pokemon_remote_datasource.dart';
import 'package:pokemons/domain/entities/pokemon.dart';
import 'package:pokemons/domain/entities/pokemon_detail.dart';
import 'package:pokemons/domain/repositories/pokemon_repository.dart';

class PokemonRepositoryImpl implements PokemonRepository {
  PokemonRepositoryImpl(this.remoteDataSource);
  final PokemonRemoteDataSource remoteDataSource;

  @override
  Future<List<Pokemon>> getPokemonList() async {
    final models = await remoteDataSource.fetchPokemonList();
    return models.map((m) => m.toEntity()).toList();
  }

  @override
  Future<PokemonDetail> getPokemonDetail(String name) async {
    final model = await remoteDataSource.fetchPokemonDetail(name);
    return model.toEntity();
  }
}
