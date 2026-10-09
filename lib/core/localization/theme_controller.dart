import 'package:flutter/material.dart';

import '../../app/theme/racing_theme.dart';
import '../storage/prefs_service.dart';

/// The three shipped visual personalities.
enum ThemePreference {
  /// Clean, high-key light UI.
  white,

  /// Deep midnight dark UI.
  black,

  /// Purple-tinted, high-contrast dark UI.
  nightOwl,
}

/// Owns the active [ThemePreference] and persists it across launches.
///
/// The actual theme composition lives in `app/theme/racing_theme.dart`; this
/// controller only maps a preference -> a `ThemeData` and broadcasts changes.
/// It is a pure presentation-layer state holder (no repository needed), so
/// living in `core/localization` alongside [LocaleController] is intentional.
class ThemeController extends ChangeNotifier {
  ThemeController({ThemePreference? preference})
    : _preference = preference ?? _readPersistedPreference();

  ThemePreference _preference;

  ThemePreference get preference => _preference;

  /// Brightness for the current preference, without building the whole theme.
  Brightness get brightness => switch (_preference) {
    ThemePreference.white => Brightness.light,
    ThemePreference.black || ThemePreference.nightOwl => Brightness.dark,
  };

  bool get isDark => brightness == Brightness.dark;

  /// The composed theme. Cached so repeated `build()` calls (and
  /// `Consumer` rebuilds) reuse the same instance instead of rebuilding
  /// `ThemeData` on every frame.
  ThemeData get themeData => _themeDataCache ??= _compose(_preference);

  ThemeData? _themeDataCache;

  static ThemePreference _readPersistedPreference() {
    final name = PrefsService.getThemeName();
    for (final p in ThemePreference.values) {
      if (p.name == name) return p;
    }
    return ThemePreference.black;
  }

  Future<void> setPreference(ThemePreference preference) async {
    if (_preference == preference) return;
    _preference = preference;
    await PrefsService.setThemeName(preference.name);
    // `themeData` is cached; it must be recomposed when the preference moves.
    _themeDataCache = _compose(preference);
    notifyListeners();
  }

  static ThemeData _compose(ThemePreference preference) => switch (preference) {
    ThemePreference.white => buildLightTheme(),
    ThemePreference.black => buildDarkTheme(),
    ThemePreference.nightOwl => buildNightTheme(),
  };
}
