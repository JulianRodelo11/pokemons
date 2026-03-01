import 'dart:ui';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'locale_provider.g.dart';

@riverpod
class LocaleNotifier extends _$LocaleNotifier {
  @override
  Locale build() {
    // Idioma por defecto. Podría detectarse del sistema.
    return const Locale('es');
  }

  void setLocale(Locale locale) {
    state = locale;
  }
}
