import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
  static const Color _selectedIconColor = Color(0xFF1565C0);
  static const Color _selectedTextColor = Color(0xFF0D47A1);

  final String svgAsset;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final unselectedColor = Theme.of(context).colorScheme.onSurfaceVariant;
    final iconColor = selected ? _selectedIconColor : unselectedColor;
    final textColor = selected ? _selectedTextColor : unselectedColor;
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

  static const Color _tabBarBg = Color(0xFFFAFAFA);
  static const Color _tabBarBorderTop = Color(0xFFE0E0E0);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _tabBarBg,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        border: const Border(
          top: BorderSide(color: _tabBarBorderTop, width: 1),
        ),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: Color(0x1F000000), // black 12%
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
