import 'package:flutter/material.dart';

/// Paleta de colores de la app. El tema Material 3 se genera desde [primary].
abstract class AppColors {
  AppColors._();

  /// Color primario / semilla del tema (Material 3 deriva el resto desde aquí).
  static const Color primary = Color(0xFF1E88E5);

  /// Color Male
  static const Color male = Color(0xFF2551C3);

  /// Color Female
  static const Color female = Color(0xFFFF7596);

  /// Color del indicador de página (onboarding, etc.).
  static const Color pageIndicator = Color(0xFF173EA5);

  static const Color textDisable = Color(0xFF9E9E9E);

  /// Color para errores o acciones destructivas (eliminar).
  static const Color error = Color(0xFFCD3131);

  /// --- Nuevos Colores de UI Centralizados ---

  /// Color de bordes y divisores claros.
  static const Color border = Color(0xFFE0E0E0);

  /// Color de fondo para hojas (bottom sheets) o superficies.
  static const Color surface = Colors.white;

  /// Color de texto principal en superficies.
  static const Color onSurface = Color(0xFF212121);

  /// Color de fondo para botones de acción secundaria (ej: cancelar).
  static const Color secondaryAction = Color(0xFFEEEEEE);

  /// Color de iconos por defecto.
  static const Color iconDefault = Color(0xFF424242);

  /// Colores para el Bottom Navigation Bar.
  static const Color navBackground = Color(0xFFFAFAFA);
  static const Color navSelectedIcon = Color(0xFF1565C0);
  static const Color navSelectedText = Color(0xFF0D47A1);

  /// Color de sombra genérico (12% black).
  static const Color shadow = Color(0x1F000000);

  /// Color de fallback para cartas sin tipo definido.
  static const Color cardFallback = Color(0xFF9DA0AA);

  /// Blanco puro para superficies o contrastes.
  static const Color white = Colors.white;

  /// --- Colores por Tipo de Pokémon ---

  static const Color grass = Color(0xFF8BC34A);
  static const Color poison = Color(0xFF9C27B0);
  static const Color fire = Color(0xFFFF9800);
  static const Color flying = Color(0xFF00BCD4);
  static const Color water = Color(0xFF2196F3);
  static const Color bug = Color(0xFF43A047);
  static const Color normal = Color(0xFF546E7A);
  static const Color electric = Color(0xFFFDD835);
  static const Color ground = Color(0xFFFFB300);
  static const Color fairy = Color(0xFFE91E63);
  static const Color fighting = Color(0xFFE53935);
  static const Color psychic = Color(0xFF673AB7);
  static const Color rock = Color(0xFF795548);
  static const Color steel = Color(0xFF546E7A);
  static const Color ice = Color(0xFF3D8BFF);
  static const Color ghost = Color(0xFF8E24AA);
  static const Color dragon = Color(0xFF00ACC1);
  static const Color dark = Color(0xFF546E7A);
}