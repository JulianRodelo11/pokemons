import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:pokemons/core/constants/app_constants.dart';
import 'package:pokemons/data/models/pokemon_detail_model.dart';
import 'package:pokemons/data/models/pokemon_model.dart';

/// DataSource remoto para PokeAPI (Dio).
abstract class PokemonRemoteDataSource {
  Future<List<PokemonModel>> fetchPokemonList();
  Future<PokemonDetailModel> fetchPokemonDetail(String name, {String? locale});
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
    //developer.log('fetchPokemonList response: $data');
    if (data == null) {
      throw DioException(requestOptions: response.requestOptions);
    }
    final results = data['results'] as List<dynamic>? ?? [];
    return results
        .map((e) => PokemonModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<PokemonDetailModel> fetchPokemonDetail(
    String name, {
    String? locale,
  }) async {
    final response = await _dio.get<Map<String, dynamic>>('/pokemon/$name');
    final data = response.data;
    //developer.log('fetchPokemonDetail($name) response: $data');
    if (data == null) {
      throw DioException(requestOptions: response.requestOptions);
    }
    final model = PokemonDetailModel.fromJson(data);
    final int id = data['id'] as int? ?? model.id;
    final speciesExtra = await _fetchSpeciesExtra(id, locale);
    final List<String> abilityUrls = _parseAbilityUrls(data);
    final Map<String, List<String>> abilityNamesByLocale =
        await _fetchAbilityNamesByLocale(abilityUrls, model.abilities);
    /*developer.log(
      'abilityNamesByLocale: es=${abilityNamesByLocale['es']}, '
      'en=${abilityNamesByLocale['en']}',
    );*/
    return model.copyWith(
      category: speciesExtra.category,
      abilityNamesByLocale: abilityNamesByLocale,
      maleRatio: speciesExtra.maleRatio,
      femaleRatio: speciesExtra.femaleRatio,
      description: speciesExtra.description,
    );
  }

  List<String> _parseAbilityUrls(Map<String, dynamic> data) {
    final List<String> urls = <String>[];
    for (final dynamic a in (data['abilities'] as List<dynamic>? ?? [])) {
      final String? url =
          (a as Map<String, dynamic>?)?['ability']?['url'] as String?;
      if (url != null && url.isNotEmpty) urls.add(url);
    }
    return urls;
  }

  /// Obtiene nombres de habilidades en español e inglés desde la API de ability.
  /// Una sola petición por habilidad; en la UI se elige la lista según el idioma actual.
  /// Origen: PokeAPI GET /ability/{id} → array "names" con name y language.name (es/en).
  Future<Map<String, List<String>>> _fetchAbilityNamesByLocale(
    List<String> abilityUrls,
    List<String> fallbackEnglish,
  ) async {
    final Map<String, List<String>> result = <String, List<String>>{
      'es': <String>[],
      'en': <String>[],
    };
    if (abilityUrls.isEmpty) return result;
    for (int i = 0; i < abilityUrls.length; i++) {
      final String url = abilityUrls[i];
      final int? abilityId = _idFromUrl(url);
      final String fallback = i < fallbackEnglish.length
          ? fallbackEnglish[i]
          : '';
      if (abilityId == null) {
        result['es']!.add(fallback);
        result['en']!.add(fallback);
        continue;
      }
      try {
        final response = await _dio.get<dynamic>(
          '/ability/$abilityId',
          options: Options(responseType: ResponseType.json),
        );
        dynamic rawData = response.data;
        if (rawData == null) {
          result['es']!.add(fallback);
          result['en']!.add(fallback);
          continue;
        }
        // Por si Dio devuelve el body como String sin parsear.
        final Map<String, dynamic> data = rawData is Map<String, dynamic>
            ? rawData
            : (rawData is String
                  ? jsonDecode(rawData) as Map<String, dynamic>
                  : <String, dynamic>{});
        final names = data['names'] as List<dynamic>? ?? [];
        String nameEs = '';
        String nameEn = '';
        for (final n in names) {
          final map = n as Map<String, dynamic>?;
          if (map == null) continue;
          final langObj = map['language'];
          final String? lang = langObj is Map<String, dynamic>
              ? langObj['name'] as String?
              : null;
          final String name = map['name'] as String? ?? '';
          if (lang != null && (lang == 'es' || lang.startsWith('es-'))) {
            nameEs = name;
          }
          if (lang != null && (lang == 'en' || lang.startsWith('en-'))) {
            nameEn = name;
          }
        }
        result['es']!.add(nameEs.isNotEmpty ? nameEs : fallback);
        result['en']!.add(nameEn.isNotEmpty ? nameEn : fallback);
        /*developer.log(
          'ability $abilityId: es="$nameEs" en="$nameEn" (fallback: "$fallback")',
        );*/
      } catch (e) {
        //developer.log('ability $abilityId error: $e', stackTrace: st);
        result['es']!.add(fallback);
        result['en']!.add(fallback);
      }
    }
    return result;
  }

  static int? _idFromUrl(String url) {
    final uri = Uri.tryParse(url);
    if (uri == null) return null;
    final segments = uri.pathSegments;
    if (segments.isEmpty) return null;
    // Último segmento que sea número (evita "" por barra final).
    for (int i = segments.length - 1; i >= 0; i--) {
      final id = int.tryParse(segments[i]);
      if (id != null && id > 0) return id;
    }
    return null;
  }

  /// Resultado de pokemon-species: categoría y proporción de género.
  /// gender_rate en API: -1 = sin género, 0 = 100% macho, 8 = 100% hembra, 1–7 = hembra = rate/8.
  static ({String category, double? maleRatio, double? femaleRatio})
  _genderFromRate(int rate) {
    if (rate < 0) return (category: '', maleRatio: null, femaleRatio: null);
    final double female = rate / 8;
    final double male = 1.0 - female;
    return (category: '', maleRatio: male, femaleRatio: female);
  }

  /// Obtiene categoría, proporción de género y descripción (flavor text) desde pokemon-species.
  Future<
    ({
      String category,
      double? maleRatio,
      double? femaleRatio,
      String description,
    })
  >
  _fetchSpeciesExtra(int speciesId, String? locale) async {
    const empty = (
      category: '',
      maleRatio: null,
      femaleRatio: null,
      description: '',
    );
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        '/pokemon-species/$speciesId',
      );
      final data = response.data;
      if (data == null) return empty;
      final int genderRate = data['gender_rate'] as int? ?? -1;
      final gender = _genderFromRate(genderRate);
      final double? maleRatio = gender.maleRatio;
      final double? femaleRatio = gender.femaleRatio;
      final genera = data['genera'] as List<dynamic>? ?? [];
      final flavorEntries = data['flavor_text_entries'] as List<dynamic>? ?? [];
      final Set<String> seen = <String>{};
      final List<String> preferredLangs = <String>[];
      if (locale != null && locale.isNotEmpty) {
        preferredLangs.add(locale);
        seen.add(locale);
      }
      for (final lang in ['en', 'es']) {
        if (seen.add(lang)) preferredLangs.add(lang);
      }
      String category = '';
      for (final lang in preferredLangs) {
        for (final g in genera) {
          final map = g as Map<String, dynamic>?;
          final langName = map?['language']?['name'] as String?;
          if (langName == lang) {
            final genus = map?['genus'] as String?;
            if (genus != null && genus.isNotEmpty) {
              category = _shortCategoryName(genus);
              break;
            }
          }
        }
        if (category.isNotEmpty) break;
      }
      if (category.isEmpty && genera.isNotEmpty) {
        final first = genera.first as Map<String, dynamic>?;
        final genus = first?['genus'] as String? ?? '';
        category = genus.isNotEmpty ? _shortCategoryName(genus) : '';
      }
      String description = '';
      for (final lang in preferredLangs) {
        for (final e in flavorEntries) {
          final map = e as Map<String, dynamic>?;
          final langName = map?['language']?['name'] as String?;
          if (langName == lang) {
            final text = map?['flavor_text'] as String?;
            if (text != null && text.isNotEmpty) {
              description = text
                  .replaceAll('\n', ' ')
                  .replaceAll('\f', ' ')
                  .trim();
              break;
            }
          }
        }
        if (description.isNotEmpty) break;
      }
      return (
        category: category,
        maleRatio: maleRatio,
        femaleRatio: femaleRatio,
        description: description,
      );
    } catch (_) {
      return empty;
    }
  }

  /// "Pokémon Semilla" → "SEMILLA", "Seed Pokémon" → "SEED". Devuelve en mayúsculas.
  static String _shortCategoryName(String genus) {
    const String prefix = 'Pokémon ';
    const String suffix = ' Pokémon';
    String shortName = genus;
    if (genus.startsWith(prefix)) shortName = genus.substring(prefix.length);
    if (genus.endsWith(suffix)) {
      shortName = genus.substring(0, genus.length - suffix.length);
    }
    return shortName.toUpperCase();
  }
}
