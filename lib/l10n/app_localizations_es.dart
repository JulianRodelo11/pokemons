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
  String get onboardingNext => 'Siguiente';

  @override
  String get onboardingStart => 'Empezar';

  @override
  String get onboardingWelcomeTitle => 'Bienvenido';

  @override
  String get onboardingWelcomeSubtitle =>
      'Explora la lista de Pokémon y descubre tus favoritos.';

  @override
  String get onboardingFavoritesTitle => 'Guarda favoritos';

  @override
  String get onboardingFavoritesSubtitle =>
      'Marca los Pokémon que más te gusten y accede a ellos cuando quieras.';

  @override
  String get homeTitle => 'Pokémon';

  @override
  String get homeEmptyList => 'No hay Pokémon';

  @override
  String homeError(String error) {
    return 'Error: $error';
  }

  @override
  String detailHeightWeight(int height, int weight) {
    return 'Altura: $height dm · Peso: $weight hg';
  }

  @override
  String get detailStats => 'Estadísticas';

  @override
  String detailError(String error) {
    return 'Error: $error';
  }
}
