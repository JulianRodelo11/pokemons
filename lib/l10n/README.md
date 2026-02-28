# Traducciones (l10n)

- **Solo se editan** los `.arb` (`app_en.arb`, `app_es.arb`). Ahí se añaden o cambian textos.
- Los `.dart` (`app_localizations.dart`, `app_localizations_*.dart`) **los genera Flutter**. No los edites a mano.
- **Cada vez que agregues o cambies una clave** en un `.arb`, ejecuta en la raíz del proyecto:
  ```bash
  flutter gen-l10n
  ```
  Así se regeneran los getters en Dart y podrás usar `AppLocalizations.of(context)!.tuNuevaClave`.
