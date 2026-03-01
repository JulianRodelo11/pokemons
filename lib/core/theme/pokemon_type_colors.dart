import 'package:flutter/material.dart';

/// Colores por tipo de Pokémon. Coinciden con el fill del primer rect
/// de cada [assets/svg/Type=...].svg para fondo de carta y consistencia visual.
abstract class PokemonTypeColors {
  PokemonTypeColors._();

  /// Colores extraídos de los SVG Type= (mismo hex que el rect de fondo del chip).
  static const Map<String, Color> _colorMap = <String, Color>{
    'grass': Color(0xFF8BC34A),   // Type=Planta.svg
    'poison': Color(0xFF9C27B0),  // Type=Veneno.svg
    'fire': Color(0xFFFF9800),    // Type=Fuego.svg
    'flying': Color(0xFF00BCD4), // Type=Volador.svg
    'water': Color(0xFF2196F3),   // Type=Agua.svg
    'bug': Color(0xFF43A047),     // Type=Bicho.svg
    'normal': Color(0xFF546E7A), // Type=Normal.svg
    'electric': Color(0xFFFDD835), // Type=Electrico.svg
    'ground': Color(0xFFFFB300),  // Type=Tierra.svg
    'fairy': Color(0xFFE91E63),   // Type=Hada.svg
    'fighting': Color(0xFFE53935), // Type=Lucha.svg
    'psychic': Color(0xFF673AB7), // Type=Psíquico.svg
    'rock': Color(0xFF795548),    // Type=Roca.svg
    'steel': Color(0xFF546E7A),   // Type=Acero.svg
    'ice': Color(0xFF3D8BFF),     // Type=Hielo.svg
    'ghost': Color(0xFF8E24AA),   // Type=Fantasma.svg
    'dragon': Color(0xFF00ACC1),  // Type=Dragon.svg
    'dark': Color(0xFF546E7A),    // Type=Siniestro.svg
  };

  static Color forType(String typeName) {
    final key = typeName.toLowerCase();
    return _colorMap[key] ?? const Color(0xFF9DA0AA);
  }

  /// Color de fondo para la carta (primera línea de tipo).
  static Color cardBackground(List<String> types) {
    if (types.isEmpty) return const Color(0xFF9DA0AA);
    return forType(types.first);
  }

  static IconData iconForType(String typeName) {
    switch (typeName.toLowerCase()) {
      case 'grass':
        return Icons.eco;
      case 'poison':
        return Icons.water_drop_outlined;
      case 'fire':
        return Icons.local_fire_department;
      case 'water':
        return Icons.water_drop;
      case 'electric':
        return Icons.bolt;
      case 'flying':
        return Icons.air;
      case 'bug':
        return Icons.bug_report;
      case 'psychic':
        return Icons.psychology;
      default:
        return Icons.circle;
    }
  }
}
