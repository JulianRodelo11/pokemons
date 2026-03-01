/// Utilidades estáticas para Pokémon (URLs, formatos, etc.).
abstract class PokemonUtils {
  PokemonUtils._();

  /// URL del artwork oficial por ID (fallback cuando el detalle no tiene imagen).
  static const String _officialArtworkBase =
      'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork';

  static String officialArtworkUrl(int id) => '$_officialArtworkBase/$id.png';

  /// Formato N°XXX para número en lista.
  static String formatNumber(int id) => 'N°${id.toString().padLeft(3, '0')}';

  /// Ruta del SVG del tipo en [assets/svg] (nombre en inglés de la API → archivo).
  /// Ej: "fire" → "assets/svg/Type=Fuego.svg"
  static const Map<String, String> typeSvgAssets = <String, String>{
    'grass': 'assets/svg/Type=Planta.svg',
    'poison': 'assets/svg/Type=Veneno.svg',
    'fire': 'assets/svg/Type=Fuego.svg',
    'flying': 'assets/svg/Type=Volador.svg',
    'water': 'assets/svg/Type=Agua.svg',
    'bug': 'assets/svg/Type=Bicho.svg',
    'normal': 'assets/svg/Type=Normal.svg',
    'electric': 'assets/svg/Type=Electrico.svg',
    'ground': 'assets/svg/Type=Tierra.svg',
    'fairy': 'assets/svg/Type=Hada.svg',
    'fighting': 'assets/svg/Type=Lucha.svg',
    'psychic': 'assets/svg/Type=Psíquico.svg',
    'rock': 'assets/svg/Type=Roca.svg',
    'steel': 'assets/svg/Type=Acero.svg',
    'ice': 'assets/svg/Type=Hielo.svg',
    'ghost': 'assets/svg/Type=Fantasma.svg',
    'dragon': 'assets/svg/Type=Dragon.svg',
    'dark': 'assets/svg/Type=Siniestro.svg',
  };

  static String? typeSvgPath(String typeName) =>
      typeSvgAssets[typeName.toLowerCase()];

  /// Ruta del SVG de fondo para la imagen del Pokémon por tipo (assets/svg/<>.svg).
  /// Si no existe, usar círculo como fallback.
  static const Map<String, String> backgroundSvgAssets = <String, String>{
    'grass': 'assets/svg/grass.svg',
    'poison': 'assets/svg/poison.svg',
    'fire': 'assets/svg/fire.svg',
    'flying': 'assets/svg/flying.svg',
    'water': 'assets/svg/water.svg',
    'bug': 'assets/svg/bug.svg',
    'normal': 'assets/svg/normal.svg',
    'electric': 'assets/svg/electric.svg',
    'ground': 'assets/svg/ground.svg',
    'fairy': 'assets/svg/fairy.svg',
    'fighting': 'assets/svg/fighting.svg',
    'psychic': 'assets/svg/psychic.svg',
    'rock': 'assets/svg/rock.svg',
    'steel': 'assets/svg/steel.svg',
    'ice': 'assets/svg/ice.svg',
    'ghost': 'assets/svg/ghost.svg',
    'dark': 'assets/svg/dark.svg',
    'dragon': 'assets/svg/Dragon.svg',
  };

  static String? backgroundSvgPath(String typeName) =>
      backgroundSvgAssets[typeName.toLowerCase()];

  /// Debilidades típicas por tipo (super efectivo). Devuelve lista única para mostrar.
  static const Map<String, List<String>> typeWeaknesses =
      <String, List<String>>{
        'grass': <String>['fire', 'ice', 'flying', 'poison', 'bug'],
        'poison': <String>['ground', 'psychic'],
        'fire': <String>['water', 'ground', 'rock'],
        'water': <String>['electric', 'grass'],
        'electric': <String>['ground'],
        'flying': <String>['electric', 'ice', 'rock'],
        'bug': <String>['fire', 'flying', 'rock'],
        'psychic': <String>['bug', 'ghost', 'dark'],
        'ice': <String>['fire', 'fighting', 'rock', 'steel'],
        'ground': <String>['water', 'grass', 'ice'],
        'rock': <String>['water', 'grass', 'fighting', 'ground', 'steel'],
        'fighting': <String>['flying', 'psychic', 'fairy'],
        'ghost': <String>['ghost', 'dark'],
        'dragon': <String>['ice', 'dragon', 'fairy'],
        'dark': <String>['fighting', 'bug', 'fairy'],
        'steel': <String>['fire', 'fighting', 'ground'],
        'fairy': <String>['poison', 'steel'],
        'normal': <String>['fighting'],
      };

  static List<String> weaknessesForTypes(List<String> types) {
    final set = <String>{};
    for (final t in types) {
      final list = typeWeaknesses[t.toLowerCase()];
      if (list != null) set.addAll(list);
    }
    return set.toList()..sort();
  }
}
