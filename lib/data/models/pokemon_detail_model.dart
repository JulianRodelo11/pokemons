import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pokemons/domain/entities/pokemon_detail.dart';

part 'pokemon_detail_model.freezed.dart';

@freezed
abstract class PokemonDetailModel with _$PokemonDetailModel {
  const PokemonDetailModel._();

  const factory PokemonDetailModel({
    required int id,
    required String name,
    required String imageUrl,
    required int height,
    required int weight,
    required List<String> types,
    required Map<String, int> stats,
    @Default('') String category,
    @Default([]) List<String> abilities,
    @Default({}) Map<String, List<String>> abilityNamesByLocale,
    double? maleRatio,
    double? femaleRatio,
    @Default('') String description,
  }) = _PokemonDetailModel;

  factory PokemonDetailModel.fromJson(Map<String, dynamic> json) {
    final Map<String, dynamic>? sprites =
        json['sprites'] as Map<String, dynamic>?;
    String? imageUrl = sprites?['front_default'] as String?;
    if (imageUrl == null || imageUrl.isEmpty) {
      final other = sprites?['other'] as Map<String, dynamic>?;
      final art = other?['official-artwork'] as Map<String, dynamic>?;
      imageUrl = art?['front_default'] as String?;
    }

    final List<String> typesList = <String>[];
    for (final dynamic t in (json['types'] as List<dynamic>? ?? [])) {
      final Map<String, dynamic>? type = t as Map<String, dynamic>?;
      final name = type?['type']?['name'] as String?;
      if (name != null) typesList.add(name);
    }

    final Map<String, int> statsMap = <String, int>{};
    for (final s in (json['stats'] as List<dynamic>? ?? [])) {
      final Map<String, dynamic>? entry = s as Map<String, dynamic>?;
      final String? statName = entry?['stat']?['name'] as String?;
      final baseStat = entry?['base_stat'] as int?;
      if (statName != null && baseStat != null) statsMap[statName] = baseStat;
    }

    final List<String> abilitiesList = <String>[];
    for (final dynamic a in (json['abilities'] as List<dynamic>? ?? [])) {
      final Map<String, dynamic>? slot = a as Map<String, dynamic>?;
      final String? abilityName = slot?['ability']?['name'] as String?;
      if (abilityName != null) abilitiesList.add(abilityName);
    }

    return PokemonDetailModel(
      id: json['id'] as int? ?? 0,
      name: json['name'] as String? ?? '',
      imageUrl: imageUrl ?? '',
      height: json['height'] as int? ?? 0,
      weight: json['weight'] as int? ?? 0,
      types: typesList,
      stats: statsMap,
      abilities: abilitiesList,
    );
  }

  PokemonDetail toEntity() => PokemonDetail(
        id: id,
        name: name,
        imageUrl: imageUrl,
        height: height,
        weight: weight,
        types: types,
        stats: stats,
        category: category,
        abilities: abilities,
        abilityNamesByLocale: abilityNamesByLocale,
        maleRatio: maleRatio,
        femaleRatio: femaleRatio,
        description: description,
      );
}
