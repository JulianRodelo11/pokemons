import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Pokémon Favorites'**
  String get appTitle;

  /// No description provided for @splashTitle.
  ///
  /// In en, this message translates to:
  /// **'Pokémon Favorites'**
  String get splashTitle;

  /// No description provided for @onboardingBack.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get onboardingBack;

  /// No description provided for @onboardingContinue.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get onboardingContinue;

  /// No description provided for @onboardingStart.
  ///
  /// In en, this message translates to:
  /// **'Let\'s start'**
  String get onboardingStart;

  /// No description provided for @onboardingWelcomeTitle.
  ///
  /// In en, this message translates to:
  /// **'All Pokémon in one place'**
  String get onboardingWelcomeTitle;

  /// No description provided for @onboardingWelcomeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Access a wide list of Pokémon from all generations created by Nintendo'**
  String get onboardingWelcomeSubtitle;

  /// No description provided for @onboardingFavoritesTitle.
  ///
  /// In en, this message translates to:
  /// **'Register and save your profile, favorite Pokémon, settings, and much more in the app.'**
  String get onboardingFavoritesTitle;

  /// No description provided for @onboardingFavoritesSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Mark the Pokémon you like most and access them whenever you want.'**
  String get onboardingFavoritesSubtitle;

  /// No description provided for @homeTitle.
  ///
  /// In en, this message translates to:
  /// **'Pokémon'**
  String get homeTitle;

  /// No description provided for @homeSearchHint.
  ///
  /// In en, this message translates to:
  /// **'Search Pokémon...'**
  String get homeSearchHint;

  /// No description provided for @homeEmptyList.
  ///
  /// In en, this message translates to:
  /// **'No Pokémon'**
  String get homeEmptyList;

  /// No description provided for @homeLoading.
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get homeLoading;

  /// No description provided for @filterSheetTitle.
  ///
  /// In en, this message translates to:
  /// **'Filter by your preferences'**
  String get filterSheetTitle;

  /// No description provided for @filterSheetTypeLabel.
  ///
  /// In en, this message translates to:
  /// **'Type'**
  String get filterSheetTypeLabel;

  /// No description provided for @filterApply.
  ///
  /// In en, this message translates to:
  /// **'Apply'**
  String get filterApply;

  /// No description provided for @filterCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get filterCancel;

  /// No description provided for @filterResultsCount.
  ///
  /// In en, this message translates to:
  /// **'{count} results found'**
  String filterResultsCount(int count);

  /// No description provided for @filterResultsCountPrefix.
  ///
  /// In en, this message translates to:
  /// **''**
  String get filterResultsCountPrefix;

  /// No description provided for @filterResultsCountSuffix.
  ///
  /// In en, this message translates to:
  /// **' results found'**
  String get filterResultsCountSuffix;

  /// No description provided for @filterClear.
  ///
  /// In en, this message translates to:
  /// **'Clear filter'**
  String get filterClear;

  /// No description provided for @navPokedex.
  ///
  /// In en, this message translates to:
  /// **'Pokedex'**
  String get navPokedex;

  /// No description provided for @navRegiones.
  ///
  /// In en, this message translates to:
  /// **'Regiones'**
  String get navRegiones;

  /// No description provided for @regionsComingSoonTitle.
  ///
  /// In en, this message translates to:
  /// **'Coming soon!'**
  String get regionsComingSoonTitle;

  /// No description provided for @regionsComingSoonDescription.
  ///
  /// In en, this message translates to:
  /// **'We are working to bring you this section. Check back later to discover all the news.'**
  String get regionsComingSoonDescription;

  /// No description provided for @navFavoritos.
  ///
  /// In en, this message translates to:
  /// **'favoritos'**
  String get navFavoritos;

  /// No description provided for @favoritesEmpty.
  ///
  /// In en, this message translates to:
  /// **'No favorites yet'**
  String get favoritesEmpty;

  /// No description provided for @favoritesEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'You haven\'t marked any Pokémon as favorite'**
  String get favoritesEmptyTitle;

  /// No description provided for @favoritesEmptySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Tap the heart icon on your favorite Pokémon and they will appear here.'**
  String get favoritesEmptySubtitle;

  /// No description provided for @navPerfil.
  ///
  /// In en, this message translates to:
  /// **'Perfil'**
  String get navPerfil;

  /// No description provided for @homeError.
  ///
  /// In en, this message translates to:
  /// **'Error: {error}'**
  String homeError(String error);

  /// No description provided for @homeErrorTitle.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong...'**
  String get homeErrorTitle;

  /// No description provided for @homeErrorDescription.
  ///
  /// In en, this message translates to:
  /// **'We couldn\'t load the information right now. Check your connection or try again later.'**
  String get homeErrorDescription;

  /// No description provided for @homeErrorRetry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get homeErrorRetry;

  /// No description provided for @detailHeightWeight.
  ///
  /// In en, this message translates to:
  /// **'Height: {height} dm · Weight: {weight} hg'**
  String detailHeightWeight(int height, int weight);

  /// No description provided for @detailLabelPeso.
  ///
  /// In en, this message translates to:
  /// **'WEIGHT'**
  String get detailLabelPeso;

  /// No description provided for @detailLabelAltura.
  ///
  /// In en, this message translates to:
  /// **'HEIGHT'**
  String get detailLabelAltura;

  /// No description provided for @detailLabelCategoria.
  ///
  /// In en, this message translates to:
  /// **'CATEGORY'**
  String get detailLabelCategoria;

  /// No description provided for @detailLabelHabilidad.
  ///
  /// In en, this message translates to:
  /// **'ABILITY'**
  String get detailLabelHabilidad;

  /// No description provided for @detailLabelGenero.
  ///
  /// In en, this message translates to:
  /// **'GENDER'**
  String get detailLabelGenero;

  /// No description provided for @detailDebilidades.
  ///
  /// In en, this message translates to:
  /// **'Weaknesses'**
  String get detailDebilidades;

  /// No description provided for @detailStats.
  ///
  /// In en, this message translates to:
  /// **'Stats'**
  String get detailStats;

  /// No description provided for @detailError.
  ///
  /// In en, this message translates to:
  /// **'Error: {error}'**
  String detailError(String error);
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'es'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
