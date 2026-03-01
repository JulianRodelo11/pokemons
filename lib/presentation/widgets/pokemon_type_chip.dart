import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pokemons/core/theme/pokemon_type_colors.dart';
import 'package:pokemons/core/utils/pokemon_utils.dart';
import 'package:pokemons/core/utils/string_utils.dart';

/// Badge de tipo de Pokémon. Usa los SVG de [assets/svg] cuando existe;
/// si no, muestra chip con color + icono Material + texto.
/// Medidas del diseño: altura 25.8, ancho hug content (~73.8).
class PokemonTypeChip extends StatelessWidget {
  const PokemonTypeChip({super.key, required this.typeName});

  static const double chipHeight = 25.8;

  final String typeName;

  @override
  Widget build(BuildContext context) {
    final path = PokemonUtils.typeSvgPath(typeName);
    if (path != null) {
      return SizedBox(
        height: chipHeight,
        child: SvgPicture.asset(
          path,
          height: chipHeight,
          fit: BoxFit.fitHeight,
        ),
      );
    }
    return _buildFallbackChip(context);
  }

  Widget _buildFallbackChip(BuildContext context) {
    final color = PokemonTypeColors.forType(typeName);
    final icon = PokemonTypeColors.iconForType(typeName);
    const verticalPadding = (chipHeight - 14) / 2; // 14 = icon size, centra contenido
    return Container(
      height: chipHeight,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: verticalPadding),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(icon, size: 14, color: Colors.white),
          const SizedBox(width: 4),
          Text(
            StringUtils.capitalize(typeName),
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
          ),
        ],
      ),
    );
  }
}
