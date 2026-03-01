import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokemons/core/constants/app_constants.dart';
import 'package:pokemons/data/datasources/pokemon_remote_datasource.dart';

/// Test del datasource real: fetchPokemonDetail('bulbasaur') debe devolver
/// abilityNamesByLocale con es=[Espesura, Clorofila].
/// Ejecutar: flutter test test/datasource_ability_integration_test.dart
void main() {
  test(
    'PokemonRemoteDataSourceImpl fetchPokemonDetail bulbasaur tiene habilidades en es y en',
    () async {
      final dio = Dio(
        BaseOptions(
          baseUrl: AppConstants.pokeApiBaseUrl,
          connectTimeout: const Duration(seconds: 15),
          receiveTimeout: const Duration(seconds: 15),
        ),
      );
      final datasource = PokemonRemoteDataSourceImpl(dio: dio);

      final model = await datasource.fetchPokemonDetail(
        'bulbasaur',
        locale: 'es',
      );

      final esNames = model.abilityNamesByLocale['es'] ?? [];
      final enNames = model.abilityNamesByLocale['en'] ?? [];

      expect(
        esNames,
        isNotEmpty,
        reason: 'Debe haber al menos una habilidad en español',
      );
      expect(
        enNames,
        isNotEmpty,
        reason: 'Debe haber al menos una habilidad en inglés',
      );

      expect(
        esNames.first,
        equals('Espesura'),
        reason: 'Primera habilidad de Bulbasaur en español debe ser Espesura',
      );
      expect(
        enNames.first,
        equals('Overgrow'),
        reason: 'Primera habilidad de Bulbasaur en inglés debe ser Overgrow',
      );
    },
  );

  test('Reproduce pasos: pokemon luego ability con el MISMO Dio', () async {
    final dio = Dio(
      BaseOptions(
        baseUrl: AppConstants.pokeApiBaseUrl,
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
      ),
    );
    // 1) Request pokemon (como hace el datasource)
    final pokemonRes = await dio.get<Map<String, dynamic>>(
      '/pokemon/bulbasaur',
    );
    final pokemonData = pokemonRes.data!;
    final abilityList = pokemonData['abilities'] as List<dynamic>? ?? [];
    final urls = <String>[];
    for (final a in abilityList) {
      final url = (a as Map<String, dynamic>)['ability']?['url'] as String?;
      if (url != null) urls.add(url);
    }
    expect(urls, isNotEmpty);
    final segments = Uri.parse(urls.first).pathSegments;
    int? id;
    for (int i = segments.length - 1; i >= 0; i--) {
      id = int.tryParse(segments[i]);
      if (id != null && id > 0) break;
    }
    expect(id, equals(65), reason: 'URL=${urls.first} segments=$segments');
    // 2) Request ability 65 con el MISMO dio
    final abilityRes = await dio.get<dynamic>(
      '/ability/65',
      options: Options(responseType: ResponseType.json),
    );

    final raw = abilityRes.data;
    expect(raw, isNotNull);
    final data = raw is Map<String, dynamic>
        ? raw
        : (raw is String
              ? (throw Exception('response was String: ${(raw).length} chars'))
              : throw Exception('raw type: ${raw.runtimeType}'));
    final names = data['names'] as List<dynamic>? ?? [];
    expect(names, isNotEmpty, reason: 'data.keys=${data.keys.toList()}');
    String nameEs = '';
    String nameEn = '';
    for (final n in names) {
      final map = n as Map<String, dynamic>?;
      if (map == null) continue;
      final langObj = map['language'];
      final lang = langObj is Map<String, dynamic>
          ? langObj['name'] as String?
          : null;
      final name = map['name'] as String? ?? '';
      if (lang == 'es' || (lang != null && lang.startsWith('es-'))) {
        nameEs = name;
      }
      if (lang == 'en' || (lang != null && lang.startsWith('en-'))) {
        nameEn = name;
      }
    }
    expect(
      nameEs,
      equals('Espesura'),
      reason: 'Después de pokemon+ability con mismo Dio',
    );
    expect(nameEn, equals('Overgrow'));
  });
}
