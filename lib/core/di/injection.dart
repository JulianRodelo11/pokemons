import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokemons/core/constants/app_constants.dart';
import 'package:pokemons/data/datasources/pokemon_remote_datasource.dart';
import 'package:pokemons/data/repositories/pokemon_repository_impl.dart';
import 'package:pokemons/domain/repositories/pokemon_repository.dart';

/// Proveedor de Dio con baseUrl de PokeAPI (permite override en tests).
final dioProvider = Provider<Dio>((ref) {
  return Dio(
    BaseOptions(
      baseUrl: AppConstants.pokeApiBaseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ),
  );
});

/// DataSource remoto.
final pokemonRemoteDataSourceProvider = Provider<PokemonRemoteDataSource>((ref) {
  return PokemonRemoteDataSourceImpl(dio: ref.watch(dioProvider));
});

/// Repositorio de Pokémon.
final pokemonRepositoryProvider = Provider<PokemonRepository>((ref) {
  return PokemonRepositoryImpl(ref.watch(pokemonRemoteDataSourceProvider));
});
