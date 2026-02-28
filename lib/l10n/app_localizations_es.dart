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
