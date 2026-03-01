import 'package:pokemons/core/constants/app_constants.dart';
import 'package:pokemons/data/datasources/pokemon_remote_datasource.dart';
import 'package:pokemons/domain/entities/pokemon.dart';
import 'package:pokemons/domain/entities/pokemon_detail.dart';
import 'package:pokemons/domain/repositories/pokemon_repository.dart';

class PokemonRepositoryImpl implements PokemonRepository {
  PokemonRepositoryImpl(this.remoteDataSource);
  final PokemonRemoteDataSource remoteDataSource;

  @override
  Future<List<Pokemon>> getPokemonList() async {
    // Fallo inmediato sin await: el Future ya viene en error y no se muestra loading.
    if (AppConstants.forcePokemonListError) {
      return Future.error(Exception('Error de prueba: lista forzada a fallar'));
    }
    final models = await remoteDataSource.fetchPokemonList();
    return models.map((m) => m.toEntity()).toList();
  }

  @override
  Future<PokemonDetail> getPokemonDetail(String name, {String? locale}) async {
    final model = await remoteDataSource.fetchPokemonDetail(name, locale: locale);
    return model.toEntity();
  }
}
