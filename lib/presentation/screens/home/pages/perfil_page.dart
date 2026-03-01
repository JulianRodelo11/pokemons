import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokemons/core/theme/app_typography.dart';
import 'package:pokemons/l10n/app_localizations.dart';
import 'package:pokemons/presentation/providers/locale_provider.dart';

class PerfilPage extends ConsumerWidget {
  const PerfilPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final currentLocale = ref.watch(localeProvider);

    return ListView(
      children: [
        const SizedBox(height: 24),
        /*Center(
          child: Text(
            l10n.navPerfil,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
          ),
        ),
        const SizedBox(height: 32),*/
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            l10n.profileChangeLanguage,
            style: AppTypography.bodyMediumLg.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
        ),
        const SizedBox(height: 10),
        Theme(
          data: Theme.of(context).copyWith(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            hoverColor: Colors.transparent,
            focusColor: Colors.transparent,
            splashFactory: NoSplash.splashFactory,
          ),
          child: Column(
            children: [
              ListTile(
                leading: const Text('🇪🇸', style: TextStyle(fontSize: 24)),
                title: Text(l10n.profileLanguageSpanish),
                trailing: currentLocale.languageCode == 'es'
                    ? Icon(
                        Icons.check,
                        color: Theme.of(context).colorScheme.primary,
                      )
                    : null,
                onTap: () => ref
                    .read(localeProvider.notifier)
                    .setLocale(const Locale('es')),
              ),
              ListTile(
                leading: const Text('🇺🇸', style: TextStyle(fontSize: 24)),
                title: Text(l10n.profileLanguageEnglish),
                trailing: currentLocale.languageCode == 'en'
                    ? Icon(
                        Icons.check,
                        color: Theme.of(context).colorScheme.primary,
                      )
                    : null,
                onTap: () => ref
                    .read(localeProvider.notifier)
                    .setLocale(const Locale('en')),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
