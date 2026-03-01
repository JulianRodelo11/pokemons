import 'package:pokemons/domain/entities/pokemon_detail.dart';

/// DTO de detalle de Pokémon desde PokeAPI.
/// Parsing manual para evitar anidación compleja con Freezed.
class PokemonDetailModel {
  const PokemonDetailModel({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.height,
    required this.weight,
    required this.types,
    required this.stats,
    this.category = '',
    this.abilities = const [],
    this.abilityNamesByLocale = const {},
    this.maleRatio,
    this.femaleRatio,
    this.description = '',
  });
  final int id;
  final String name;
  final String imageUrl;
  final int height;
  final int weight;
  final List<String> types;
  final Map<String, int> stats;
  final String category;
  final List<String> abilities;
  final Map<String, List<String>> abilityNamesByLocale;
  final double? maleRatio;
  final double? femaleRatio;
  final String description;

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

  PokemonDetailModel copyWith({
    String? category,
    List<String>? abilities,
    Map<String, List<String>>? abilityNamesByLocale,
    double? maleRatio,
    double? femaleRatio,
    String? description,
  }) => PokemonDetailModel(
    id: id,
    name: name,
    imageUrl: imageUrl,
    height: height,
    weight: weight,
    types: types,
    stats: stats,
    category: category ?? this.category,
    abilities: abilities ?? this.abilities,
    abilityNamesByLocale: abilityNamesByLocale ?? this.abilityNamesByLocale,
    maleRatio: maleRatio ?? this.maleRatio,
    femaleRatio: femaleRatio ?? this.femaleRatio,
    description: description ?? this.description,
  );

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
