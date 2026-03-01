import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pokemons/core/theme/theme.dart';

/// Barra de búsqueda: input tipo pill y botón circular, fondo blanco y borde gris claro.
class HomeSearchBar extends StatelessWidget {
  const HomeSearchBar({
    super.key,
    required this.controller,
    required this.hint,
    this.onSearchButtonTap,
  });

  final TextEditingController controller;
  final String hint;
  final VoidCallback? onSearchButtonTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Container(
              height: 48,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(50),
                border: Border.all(color: AppColors.border, width: 1),
              ),
              child: Stack(
                alignment: Alignment.centerLeft,
                children: <Widget>[
                  TextField(
                    controller: controller,
                    style: const TextStyle(color: Colors.black87),
                    decoration: InputDecoration(
                      hintText: hint,
                      hintStyle: AppTypography.searchHint.copyWith(
                        color: AppColors.textDisable,
                      ),
                      border: InputBorder.none,
                      filled: true,
                      fillColor: Colors.transparent,
                      contentPadding: const EdgeInsets.only(left: 40),
                      isDense: true,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 14),
                    child: SvgPicture.asset(
                      'assets/svg/search.svg',
                      width: 20,
                      height: 20,
                      colorFilter: const ColorFilter.mode(
                        AppColors.textDisable,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: onSearchButtonTap,
            child: Container(
              height: 48,
              width: 48,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.border, width: 1),
              ),
              alignment: Alignment.center,
              child: Icon(
                Icons.filter_list,
                color: AppColors.textDisable,
                size: 24,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
