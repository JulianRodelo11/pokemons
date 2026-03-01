import 'dart:convert';
import 'dart:developer' as developer;

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

/// Test que llama a PokeAPI /ability/65 y comprueba que devuelve nombres en es y en.
/// Ejecutar: flutter test test/ability_names_api_test.dart
void main() {
  late Dio dio;

  setUp(() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://pokeapi.co/api/v2',
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
      ),
    );
  });

  test(
    'GET /ability/65 devuelve names con es (Espesura) y en (Overgrow)',
    () async {
      final response = await dio.get<dynamic>(
        '/ability/65',
        options: Options(responseType: ResponseType.json),
      );

      final rawData = response.data;
      expect(rawData, isNotNull);

      final Map<String, dynamic> data = rawData is Map<String, dynamic>
          ? rawData
          : (rawData is String
                ? jsonDecode(rawData) as Map<String, dynamic>
                : <String, dynamic>{});

      final names = data['names'] as List<dynamic>? ?? [];
      expect(
        names,
        isNotEmpty,
        reason: 'El array "names" debe existir y no estar vacío',
      );

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

      developer.log('Parsed: es="$nameEs" en="$nameEn"');
      expect(nameEs, isNotEmpty, reason: 'Debe existir nombre en español');
      expect(nameEn, isNotEmpty, reason: 'Debe existir nombre en inglés');
      expect(
        nameEs,
        equals('Espesura'),
        reason: 'Ability 65 en español es "Espesura"',
      );
      expect(
        nameEn,
        equals('Overgrow'),
        reason: 'Ability 65 en inglés es "Overgrow"',
      );
    },
  );
}
