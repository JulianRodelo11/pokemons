import 'package:flutter/material.dart';
import 'package:pokemons/core/utils/pokemon_utils.dart';
import 'package:pokemons/domain/entities/pokemon_detail.dart';
import 'package:pokemons/presentation/widgets/pokemon_background_svg.dart';

class PokemonDetailHeader extends StatelessWidget {
  const PokemonDetailHeader({
    super.key,
    required this.detail,
    required this.cardColor,
    this.drawCircle = false,
    this.heroTagSuffix = 0,
  });

  final PokemonDetail detail;
  final Color cardColor;
  final bool drawCircle;
  /// Sufijo para los Hero tags (p. ej. listIndex de la carta que abrió el detalle).
  final int heroTagSuffix;

  @override
  Widget build(BuildContext context) {
    final String? bgSvg = detail.types.isNotEmpty
        ? PokemonUtils.backgroundSvgPath(detail.types.first)
        : null;
    const double headerHeight = 300;
    final double width = MediaQuery.sizeOf(context).width;

    return Stack(
      clipBehavior: Clip.none,
      children: <Widget>[
        if (drawCircle)
          Hero(
            tag: 'pokemon-card-bg-${detail.name}-$heroTagSuffix',
            child: SizedBox(
              height: headerHeight,
              width: width,
              child: CustomPaint(
                painter: _CircleBackgroundPainter(color: cardColor),
                size: Size(width, headerHeight),
              ),
            ),
          ),
        if (bgSvg != null)
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: SizedBox(
              height: headerHeight,
              width: double.infinity,
              child: Center(
                child: Hero(
                  tag: 'pokemon-bg-svg-${detail.name}-$heroTagSuffix',
                  child: PokemonBackgroundSvg(
                    svgPath: bgSvg,
                    width: 204,
                    height: 204,
                  ),
                ),
              ),
            ),
          ),
        Positioned(
          left: 0,
          right: 0,
          top: 40,
          child: Center(
            child: Hero(
              tag: 'pokemon-image-${detail.name}-$heroTagSuffix',
              child: detail.imageUrl.isNotEmpty
                  ? Image.network(
                      detail.imageUrl,
                      height: 320,
                      fit: BoxFit.contain,
                      errorBuilder: (BuildContext _, _, StackTrace? _) => Icon(
                        Icons.image_not_supported_rounded,
                        size: 120,
                        color: Colors.grey.shade400,
                      ),
                    )
                  : Icon(
                      Icons.image_not_supported_rounded,
                      size: 120,
                      color: Colors.grey.shade400,
                    ),
            ),
          ),
        ),
      ],
    );
  }
}

class _CircleBackgroundPainter extends CustomPainter {
  _CircleBackgroundPainter({required this.color});
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final double w = size.width;
    final double h = size.height;
    final double radius = (w * w * 0.25 + h * h) / (2 * h);
    final Offset center = Offset(w * 0.5, h - radius);

    canvas.save();
    final double paddingY = radius * 2;
    canvas.clipRect(Rect.fromLTWH(0, -paddingY, w, h + paddingY));
    canvas.drawCircle(center, radius, Paint()..color = color);
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
