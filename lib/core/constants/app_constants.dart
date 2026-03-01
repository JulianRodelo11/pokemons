/// Constantes de la aplicación (URLs, keys, dimensiones, etc.)
class AppConstants {
  AppConstants._();

  // --- API ---
  static const String pokeApiBaseUrl = 'https://pokeapi.co/api/v2';

  /// Si true, getPokemonList() lanza error al instante sin llamar a la API (solo para probar UI de error).
  static bool forcePokemonListError = false;

  // --- UX/UI Animations ---
  static const Duration splashDuration = Duration(milliseconds: 2500);
  static const Duration splashFadeDuration = Duration(milliseconds: 400);
  static const Duration animationFast = Duration(milliseconds: 300);

  // --- Layout Dimensions ---

  /// Altura estándar de las tarjetas de Pokémon en la lista.
  static const double pokemonCardHeight = 102.0;

  /// Radio de borde estándar para tarjetas y botones principales.
  static const double borderRadiusMd = 16.0;

  /// Radio de borde para elementos más grandes como BottomSheets.
  static const double borderRadiusLg = 24.0;

  /// Tamaños de iconos estándar.
  static const double iconSizeSm = 16.0;
  static const double iconSizeMd = 24.0;
  static const double iconSizeLg = 32.0;

  /// Altura del BottomSheet de filtros.
  static const double filterSheetHeight = 614.0;
}
