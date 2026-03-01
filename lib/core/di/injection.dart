import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokemons/core/constants/app_constants.dart';
import 'package:pokemons/data/datasources/pokemon_remote_datasource.dart';
import 'package:pokemons/data/repositories/pokemon_repository_impl.dart';
import 'package:pokemons/domain/repositories/pokemon_repository.dart';

/// Proveedor de Dio con baseUrl de PokeAPI (permite override en tests).
final dioProvider = Provider<Dio>((ref) {
  final dio = Dio(
    BaseOptions(
      baseUrl: AppConstants.pokeApiBaseUrl,
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 10),
    ),
  );
  // Si la URL es de prueba (invalid-url), fallar al instante sin tocar la red.
  if (AppConstants.pokeApiBaseUrl.contains('invalid-url')) {
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          handler.reject(
            DioException(
              requestOptions: options,
              error: 'URL de prueba inválida',
            ),
          );
        },
      ),
    );
  }
  return dio;
});

/// DataSource remoto.
final pokemonRemoteDataSourceProvider = Provider<PokemonRemoteDataSource>((
  ref,
) {
  return PokemonRemoteDataSourceImpl(dio: ref.watch(dioProvider));
});

/// Repositorio de Pokémon.
final pokemonRepositoryProvider = Provider<PokemonRepository>((ref) {
  return PokemonRepositoryImpl(ref.watch(pokemonRemoteDataSourceProvider));
});
