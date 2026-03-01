/// Constantes de la aplicación (URLs, keys, etc.)
class AppConstants {
  AppConstants._();

  static const String pokeApiBaseUrl = 'https://pokeapi.co/api/v2';

  /// Si true, getPokemonList() lanza error al instante sin llamar a la API (solo para probar UI de error).
  static const bool forcePokemonListError = false;
}
