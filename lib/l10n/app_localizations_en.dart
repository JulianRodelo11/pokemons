// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Pokémon Favorites';

  @override
  String get splashTitle => 'Pokémon Favorites';

  @override
  String get onboardingBack => 'Back';

  @override
  String get onboardingNext => 'Next';

  @override
  String get onboardingStart => 'Get started';

  @override
  String get onboardingWelcomeTitle => 'Welcome';

  @override
  String get onboardingWelcomeSubtitle =>
      'Explore the Pokémon list and discover your favorites.';

  @override
  String get onboardingFavoritesTitle => 'Save favorites';

  @override
  String get onboardingFavoritesSubtitle =>
      'Mark the Pokémon you like most and access them whenever you want.';

  @override
  String get homeTitle => 'Pokémon';

  @override
  String get homeEmptyList => 'No Pokémon';

  @override
  String homeError(String error) {
    return 'Error: $error';
  }

  @override
  String detailHeightWeight(int height, int weight) {
    return 'Height: $height dm · Weight: $weight hg';
  }

  @override
  String get detailStats => 'Stats';

  @override
  String detailError(String error) {
    return 'Error: $error';
  }
}
