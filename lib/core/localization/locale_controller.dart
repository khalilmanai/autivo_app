import 'package:flutter/material.dart';

import '../../l10n/translations/strings.g.dart';
import '../constants/app_constants.dart';
import '../storage/prefs_service.dart';

class LocaleController extends ChangeNotifier {
  Locale _locale;

  LocaleController({Locale? locale})
    : _locale = locale ?? _getPersistedLocale() {
    _applyLocaleLocaleSettings();
  }

  Locale get locale => _locale;

  static Locale _getPersistedLocale() {
    final code = PrefsService.getLanguage();
    if (code != null && SupportedLanguages.codes.contains(code)) {
      return Locale(code);
    }
    return const Locale('en');
  }

  /// Applies the locale to slang's [LocaleSettings].
  ///
  /// Non-default locales are generated as deferred imports, so we must use
  /// the async API, which loads the deferred translation library first.
  Future<void> _applyLocaleLocaleSettings() async {
    await LocaleSettings.setLocaleRaw(_locale.languageCode);
  }

  Future<void> setLocale(Locale locale) async {
    if (_locale == locale) return;
    _locale = locale;
    await PrefsService.setLanguage(locale.languageCode);
    await _applyLocaleLocaleSettings();
    notifyListeners();
  }
}
