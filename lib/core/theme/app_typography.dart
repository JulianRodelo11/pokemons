import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Estilos de texto de la app.
abstract class AppTypography {
  AppTypography._();

  /// Título medio: Poppins Medium 26px, line-height 100%.
  /// Uso: pantallas principales, onboarding, etc.
  static TextStyle get headingMedium => GoogleFonts.poppins(
    fontWeight: FontWeight.w500,
    fontSize: 26,
    height: 1.0,
    letterSpacing: 0,
  );

  /// Subtítulo / cuerpo: Poppins Regular 14px, line-height 150%.
  static TextStyle get bodyMedium => GoogleFonts.poppins(
    fontWeight: FontWeight.w400,
    fontSize: 14,
    height: 1.5,
    letterSpacing: 0,
  );

  /// Etiqueta de botón: Poppins SemiBold 18px, line-height lg, center.
  static TextStyle get buttonLabel => GoogleFonts.poppins(
    fontWeight: FontWeight.w600,
    fontSize: 18,
    height: 1.5,
    letterSpacing: 0,
  );

  /// Número del Pokémon en la carta: Poppins SemiBold 12px, line-height 100%.
  static TextStyle get pokemonCardNumber => GoogleFonts.poppins(
    fontWeight: FontWeight.w600,
    fontSize: 12,
    height: 1.0,
    letterSpacing: 0,
  );

  /// Nombre del Pokémon en la carta: Poppins SemiBold 21px, line-height 100%.
  static TextStyle get pokemonCardName => GoogleFonts.poppins(
    fontWeight: FontWeight.w600,
    fontSize: 21,
    height: 1.0,
    letterSpacing: 0,
  );

  /// Placeholder de búsqueda: Poppins Regular 14px, line-height 100%.
  static TextStyle get searchHint => GoogleFonts.poppins(
    fontWeight: FontWeight.w400,
    fontSize: 14,
    height: 1.0,
    letterSpacing: 0,
  );

  /// Título 2xl: Poppins SemiBold 24px, line-height 32px. Uso: títulos de sheets, modales.
  static TextStyle get heading2xl => GoogleFonts.poppins(
    fontWeight: FontWeight.w600,
    fontSize: 24,
    height: 32 / 24,
    letterSpacing: 0,
  );

  /// Cuerpo lg: Poppins SemiBold 18px, line-height lg (28px). Uso: labels en sheets, secciones.
  static TextStyle get bodySemiBoldLg => GoogleFonts.poppins(
    fontWeight: FontWeight.w600,
    fontSize: 18,
    height: 28 / 18,
    letterSpacing: 0,
  );

  /// Cuerpo md: Montserrat Medium 16px, line-height md (24px). Uso: ítems de lista en sheets.
  static TextStyle get bodyMediumMd => GoogleFonts.montserrat(
    fontWeight: FontWeight.w500,
    fontSize: 14,
    height: 24 / 16,
    letterSpacing: 0,
  );

  /// Cuerpo md Bold: Poppins Bold 16px, line-height md (24px). Tipografía/Family, weight 700.
  static TextStyle get bodyBoldMd => GoogleFonts.montserrat(
    fontWeight: FontWeight.w700,
    fontSize: 14,
    height: 24 / 16,
    letterSpacing: 0,
  );

  /// Cuerpo md Medium subrayado: Poppins Medium 16px, line-height md (24px), underline.
  static TextStyle get bodyMediumMdUnderline => GoogleFonts.poppins(
    fontWeight: FontWeight.w500,
    fontSize: 14,
    height: 24 / 16,
    letterSpacing: 0,
    decoration: TextDecoration.underline,
    decorationStyle: TextDecorationStyle.solid,
  );

  /// Poppins Medium 18px, line-height 100%, letter-spacing 0.
  static TextStyle get bodyMediumLg => GoogleFonts.poppins(
    fontWeight: FontWeight.w500,
    fontSize: 18,
    height: 1.0,
    letterSpacing: 0,
  );

  /// Poppins Medium 12px, line-height 100%, letter-spacing 5% (0.6px). Para etiquetas en mayúsculas.
  /// Usar [String.toUpperCase()] al pasar el texto.
  static TextStyle get labelMediumXs => GoogleFonts.poppins(
    fontWeight: FontWeight.w500,
    fontSize: 12,
    height: 1.0,
    letterSpacing: 12 * 0.05, // 5% del tamaño
  );
}
