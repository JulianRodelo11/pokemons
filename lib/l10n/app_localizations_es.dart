// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'Pokémon Favoritos';

  @override
  String get splashTitle => 'Pokémon Favoritos';

  @override
  String get onboardingBack => 'Atrás';

  @override
  String get onboardingContinue => 'Continuar';

  @override
  String get onboardingStart => 'Empecemos';

  @override
  String get onboardingWelcomeTitle => 'Todos los Pokémon en un solo lugar';

  @override
  String get onboardingWelcomeSubtitle =>
      'Accede a una amplia lista de Pokémon de todas las generaciones creadas por Nintendo';

  @override
  String get onboardingFavoritesTitle => 'Mantén tu Pokédex actualizada';

  @override
  String get onboardingFavoritesSubtitle =>
      'Regístrate y guarda tu perfil, Pokémon favoritos, configuraciones y mucho más en la aplicación';

  @override
  String get homeTitle => 'Pokémon';

  @override
  String get homeSearchHint => 'Procurar Pokémon...';

  @override
  String get homeEmptyList => 'No hay Pokémon';

  @override
  String get navPokedex => 'Pokedex';

  @override
  String get navRegiones => 'Regiones';

  @override
  String get regionsComingSoonTitle => '¡Muy pronto disponible!';

  @override
  String get regionsComingSoonDescription =>
      'Estamos trabajando para traerte esta sección. Vuelve más adelante para descubrir todas las novedades.';

  @override
  String get navFavoritos => 'favoritos';

  @override
  String get favoritesEmpty => 'No tienes favoritos';

  @override
  String get favoritesEmptyTitle =>
      'No has marcado ningún Pokémon como favorito';

  @override
  String get favoritesEmptySubtitle =>
      'Haz clic en el ícono de corazón de tus Pokémon favoritos y aparecerán aquí.';

  @override
  String get navPerfil => 'Perfil';

  @override
  String homeError(String error) {
    return 'Error: $error';
  }

  @override
  String get homeErrorTitle => 'Algo salió mal...';

  @override
  String get homeErrorDescription =>
      'No pudimos cargar la información en este momento. Verifica tu conexión o intenta nuevamente más tarde.';

  @override
  String get homeErrorRetry => 'Reintentar';

  @override
  String detailHeightWeight(int height, int weight) {
    return 'Altura: $height dm · Peso: $weight hg';
  }

  @override
  String get detailLabelPeso => 'PESO';

  @override
  String get detailLabelAltura => 'ALTURA';

  @override
  String get detailLabelCategoria => 'CATEGORÍA';

  @override
  String get detailLabelHabilidad => 'HABILIDAD';

  @override
  String get detailLabelGenero => 'GENERO';

  @override
  String get detailDebilidades => 'Debilidades';

  @override
  String get detailStats => 'Estadísticas';

  @override
  String detailError(String error) {
    return 'Error: $error';
  }
}
