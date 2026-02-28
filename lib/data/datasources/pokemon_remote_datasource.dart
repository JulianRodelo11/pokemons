import 'package:dio/dio.dart';
import 'package:pokemons/core/constants/app_constants.dart';
import 'package:pokemons/data/models/pokemon_detail_model.dart';
import 'package:pokemons/data/models/pokemon_model.dart';

/// DataSource remoto para PokeAPI (Dio).
abstract class PokemonRemoteDataSource {
  Future<List<PokemonModel>> fetchPokemonList();
  Future<PokemonDetailModel> fetchPokemonDetail(String name);
}

class PokemonRemoteDataSourceImpl implements PokemonRemoteDataSource {
  PokemonRemoteDataSourceImpl({Dio? dio})
    : _dio = dio ?? Dio(BaseOptions(baseUrl: AppConstants.pokeApiBaseUrl));

  final Dio _dio;

  @override
  Future<List<PokemonModel>> fetchPokemonList() async {
    const int limit = 20;
    final Response<Map<String, dynamic>> response = await _dio
        .get<Map<String, dynamic>>(
          '/pokemon',
          queryParameters: {'limit': limit},
        );
    final data = response.data;
    if (data == null) {
      throw DioException(requestOptions: response.requestOptions);
    }
    final results = data['results'] as List<dynamic>? ?? [];
    return results
        .map((e) => PokemonModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<PokemonDetailModel> fetchPokemonDetail(String name) async {
    final response = await _dio.get<Map<String, dynamic>>('/pokemon/$name');
    final data = response.data;
    if (data == null) {
      throw DioException(requestOptions: response.requestOptions);
    }
    return PokemonDetailModel.fromJson(data);
  }
}
