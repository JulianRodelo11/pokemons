import 'package:flutter/material.dart';
import 'package:pokemons/core/theme/app_colors.dart';

/// Colores por tipo de Pokémon. Coinciden con el fill del primer rect
/// de cada [assets/svg/Type=...].svg para fondo de carta y consistencia visual.
abstract class PokemonTypeColors {
  PokemonTypeColors._();

  /// Colores extraídos de los SVG Type= (mismo hex que el rect de fondo del chip).
  static const Map<String, Color> _colorMap = <String, Color>{
    'grass': AppColors.grass,
    'poison': AppColors.poison,
    'fire': AppColors.fire,
    'flying': AppColors.flying,
    'water': AppColors.water,
    'bug': AppColors.bug,
    'normal': AppColors.normal,
    'electric': AppColors.electric,
    'ground': AppColors.ground,
    'fairy': AppColors.fairy,
    'fighting': AppColors.fighting,
    'psychic': AppColors.psychic,
    'rock': AppColors.rock,
    'steel': AppColors.steel,
    'ice': AppColors.ice,
    'ghost': AppColors.ghost,
    'dragon': AppColors.dragon,
    'dark': AppColors.dark,
  };

  static Color forType(String typeName) {
    final key = typeName.toLowerCase();
    return _colorMap[key] ?? AppColors.cardFallback;
  }

  /// Color de fondo para la carta (primera línea de tipo).
  static Color cardBackground(List<String> types) {
    if (types.isEmpty) return AppColors.cardFallback;
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