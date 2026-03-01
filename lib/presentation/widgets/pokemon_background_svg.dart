import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pokemons/core/theme/app_colors.dart';

/// SVG de fondo por tipo con gradiente blanco → blanco 15% opacidad.
/// Usado como hijo del Hero en la carta y en el detalle para que la animación
/// muestre el mismo contenido (gradiente + SVG) en ambos lados.
class PokemonBackgroundSvg extends StatelessWidget {
  const PokemonBackgroundSvg({
    super.key,
    required this.svgPath,
    required this.width,
    required this.height,
    this.opacity = 1.0,
  });

  final String svgPath;
  final double width;
  final double height;
  final double opacity;

  /// Mismo gradiente en carta y detalle: blanco arriba → blanco 15% abajo.
  static const LinearGradient _gradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: <Color>[AppColors.white, Color(0x26FFFFFF)],
  );

  @override
  Widget build(BuildContext context) {
    Widget content = SizedBox(
      width: width,
      height: height,
      child: ShaderMask(
        blendMode: BlendMode.srcIn,
        shaderCallback: (Rect bounds) => _gradient.createShader(bounds),
        child: SvgPicture.asset(
          svgPath,
          width: width,
          height: height,
          fit: BoxFit.contain,
        ),
      ),
    );
    if (opacity < 1.0) {
      content = Opacity(opacity: opacity, child: content);
    }
    return content;
  }
}
