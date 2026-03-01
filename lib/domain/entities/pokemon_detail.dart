/// Entidad de dominio: detalle de un Pokémon.
class PokemonDetail {
  const PokemonDetail({
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
  /// Nombres en inglés (fallback cuando no hay mapa por idioma).
  final List<String> abilities;
  /// Nombres de habilidades por idioma: {'es': ['Espesura', ...], 'en': ['Overgrow', ...]}.
  /// En la UI usar [abilityNamesByLocale[locale]] según el idioma actual.
  final Map<String, List<String>> abilityNamesByLocale;
  /// Proporción macho (0.0–1.0). Null si la especie no tiene género (genderless).
  final double? maleRatio;
  /// Proporción hembra (0.0–1.0). Null si la especie no tiene género (genderless).
  final double? femaleRatio;
  /// Descripción (flavor text) del Pokémon desde pokemon-species, en el idioma de la app.
  final String description;
}
