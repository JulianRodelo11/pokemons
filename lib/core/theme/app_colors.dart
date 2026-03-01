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
}
