import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pokemons/core/theme/theme.dart';

/// Ítem de la barra de navegación inferior. Icono 24×24; seleccionado = azules del diseño, no seleccionado = gris.
class HomeNavItem extends StatelessWidget {
  const HomeNavItem({
    super.key,
    required this.svgAsset,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  static const double _iconSize = 24;

  final String svgAsset;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final unselectedColor = AppColors.textDisable;
    final iconColor = selected ? AppColors.navSelectedIcon : unselectedColor;
    final textColor = selected ? AppColors.navSelectedText : unselectedColor;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SvgPicture.asset(
              svgAsset,
              width: _iconSize,
              height: _iconSize,
              colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(color: textColor),
            ),
          ],
        ),
      ),
    );
  }
}

/// Barra de navegación inferior. Especificaciones: bg #FAFAFA, borde superior 1px #E0E0E0, sombra 12% 0 -1 blur 3.
class HomeBottomNav extends StatelessWidget {
  const HomeBottomNav({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.navBackground,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        border: Border(
          top: BorderSide(color: AppColors.border, width: 1),
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: AppColors.shadow,
            offset: Offset(0, -1),
            blurRadius: 3,
            spreadRadius: 0,
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: child,
        ),
      ),
    );
  }
}