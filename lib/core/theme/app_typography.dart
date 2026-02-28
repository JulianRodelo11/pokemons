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
}
