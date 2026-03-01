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
  String get onboardingContinue => 'Continue';

  @override
  String get onboardingStart => 'Let\'s start';

  @override
  String get onboardingWelcomeTitle => 'All Pokémon in one place';

  @override
  String get onboardingWelcomeSubtitle =>
      'Access a wide list of Pokémon from all generations created by Nintendo';

  @override
  String get onboardingFavoritesTitle =>
      'Register and save your profile, favorite Pokémon, settings, and much more in the app.';

  @override
  String get onboardingFavoritesSubtitle =>
      'Mark the Pokémon you like most and access them whenever you want.';

  @override
  String get homeTitle => 'Pokémon';

  @override
  String get homeSearchHint => 'Search Pokémon...';

  @override
  String get homeEmptyList => 'No Pokémon';

  @override
  String get navPokedex => 'Pokedex';

  @override
  String get navRegiones => 'Regiones';

  @override
  String get regionsComingSoonTitle => 'Coming soon!';

  @override
  String get regionsComingSoonDescription =>
      'We are working to bring you this section. Check back later to discover all the news.';

  @override
  String get navFavoritos => 'favoritos';

  @override
  String get favoritesEmpty => 'No favorites yet';

  @override
  String get favoritesEmptyTitle =>
      'You haven\'t marked any Pokémon as favorite';

  @override
  String get favoritesEmptySubtitle =>
      'Tap the heart icon on your favorite Pokémon and they will appear here.';

  @override
  String get navPerfil => 'Perfil';

  @override
  String homeError(String error) {
    return 'Error: $error';
  }

  @override
  String get homeErrorTitle => 'Something went wrong...';

  @override
  String get homeErrorDescription =>
      'We couldn\'t load the information right now. Check your connection or try again later.';

  @override
  String get homeErrorRetry => 'Retry';

  @override
  String detailHeightWeight(int height, int weight) {
    return 'Height: $height dm · Weight: $weight hg';
  }

  @override
  String get detailLabelPeso => 'WEIGHT';

  @override
  String get detailLabelAltura => 'HEIGHT';

  @override
  String get detailLabelCategoria => 'CATEGORY';

  @override
  String get detailLabelHabilidad => 'ABILITY';

  @override
  String get detailLabelGenero => 'GENDER';

  @override
  String get detailDebilidades => 'Weaknesses';

  @override
  String get detailStats => 'Stats';

  @override
  String detailError(String error) {
    return 'Error: $error';
  }
}
