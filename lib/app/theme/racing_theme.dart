/// Single source of truth for the Autivo design system.
///
/// This library owns design tokens only (palette, schemes, typography,
/// gradients, radii, spacing, motion). It never exports anything and never
/// depends on `core/` or `presentation/`, so the dependency graph stays
/// strictly `app/theme -> flutter`.
///
/// Consumers must import `app/theme/index.dart` (the barrel), never this file
/// directly, to keep the public surface explicit.
library;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ============================================================================
// PALETTE
// ============================================================================

// Midnight / night racing base
const Color midnightBlue = Color(0xFF0F0C29);
const Color navy = Color(0xFF1A1A2E);
const Color royalBlue = Color(0xFF0D0D22);
const Color midnight = Color(0xFF1E293B);
const Color steel = Color(0xFF2A4365);

// Accents
const Color electricBlue = Color(0xFF3B82F6);
const Color cyanAccent = Color(0xFF06D6A0);
const Color limeAccent = Color(0xFFA3E4D7);
const Color orangePulse = Color(0xFFF97316);
const Color magentaAccent = Color(0xFFEC4899);
const Color sunsetOrange = Color(0xFFFB923C);

// Neutrals
const Color cream = Color(0xFFF8FAFC);
const Color slate = Color(0xFF64748B);

// Semantic / status palette
const Color racingGreen = Color(0xFF10B981);
const Color racingAmber = Color(0xFFF59E0B);
const Color racingBlue = Color(0xFF3B82F6);
const Color racingPurple = Color(0xFF8B5CF2);
const Color racingOrange = Color(0xFFF97316);
const Color racingRed = Color(0xFFEF4444);
const Color racingYellow = Color(0xFFF59E0B);
const Color racingIndigo = Color(0xFF8B5CF6);

/// Vehicle / part status colors used by badges and legends.
class StatusColors {
  const StatusColors._();

  static const Color active = racingGreen;
  static const Color maintenance = racingAmber;
  static const Color inactive = Color(0xFF64748B);
  static const Color original = racingGreen;
  static const Color replaced = electricBlue;
  static const Color serviced = racingPurple;
  static const Color worn = racingOrange;
  static const Color damaged = racingRed;
}

// ============================================================================
// GEOMETRY TOKENS
// ============================================================================

/// Corner radii scale. One place to change roundness across the whole app.
abstract final class AppRadius {
  const AppRadius._();

  static const double button = 14;
  static const double input = 20;
  static const double card = 20;
  static const double sheet = 28;
  static const double badge = 12;
  static const double avatar = 32;
  static const double pill = 999;
}

/// 4pt spacing scale. Prefer these over magic numbers.
abstract final class AppSpacing {
  const AppSpacing._();

  static const double xxs = 4;
  static const double xs = 8;
  static const double sm = 12;
  static const double md = 16;
  static const double lg = 20;
  static const double xl = 24;
  static const double xxl = 32;
  static const double huge = 40;

  /// Default horizontal gutter for screen content.
  static const double gutter = 20;
}

// ============================================================================
// MOTION TOKENS
// ============================================================================

/// Named durations + curves so transitions feel consistent everywhere.
abstract final class AppMotion {
  const AppMotion._();

  static const Duration instant = Duration(milliseconds: 120);
  static const Duration fast = Duration(milliseconds: 200);
  static const Duration normal = Duration(milliseconds: 300);
  static const Duration slow = Duration(milliseconds: 450);
  static const Duration deliberate = Duration(milliseconds: 600);

  static const Curve enter = Curves.easeOutCubic;
  static const Curve exit = Curves.easeInCubic;
  static const Curve emphasized = Curves.easeOutBack;
  static const Curve smooth = Curves.easeInOutCubic;
}

/// Backwards-compatible curve holder.
class AutomotiveCurves {
  const AutomotiveCurves._();

  static const Curve cardEnter = Curves.easeOutCubic;
  static const Curve buttonPress = Curves.easeInOutCubic;
  static const Curve progressive = Curves.easeOutCubic;
  static const Curve bounce = Curves.easeOutBack;
}

// ============================================================================
// GRADIENTS
// ============================================================================

/// Signature brand gradients.
///
/// These are intentionally *static* so they can be shared from
/// `BoxDecoration`s that are built outside a `BuildContext` (const-ish
/// decoration usage, tests, and previews).
abstract final class AppGradients {
  const AppGradients._();

  /// Primary brand ramp: electric blue -> cyan.
  static const LinearGradient primary = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [electricBlue, Color(0xFF06B6D4)],
  );

  /// Performance ramp used for hero headers and CTAs.
  static const LinearGradient performance = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [racingPurple, electricBlue],
  );

  /// Success / health ramp.
  static const LinearGradient success = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [racingGreen, cyanAccent],
  );

  /// Warning / attention ramp.
  static const LinearGradient warning = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [sunsetOrange, racingAmber],
  );

  /// Destructive ramp.
  static const LinearGradient danger = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [racingRed, racingOrange],
  );

  /// Deep midnight ramp for splash and empty states.
  static const LinearGradient midnightRamp = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [midnightBlue, royalBlue],
  );

  /// Subtle surface wash used behind scrollable content.
  static LinearGradient surfaceWash(ColorScheme scheme) => LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      scheme.surface,
      Color.alphaBlend(scheme.primary.withValues(alpha: 0.06), scheme.surface),
      scheme.surface,
    ],
  );

  /// Border gradient for elevated/outlined surfaces.
  static LinearGradient subtleBorder(ColorScheme scheme) => LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      scheme.primary.withValues(alpha: 0.35),
      scheme.secondary.withValues(alpha: 0.15),
    ],
  );
}

// ============================================================================
// COLOR SCHEMES
// ============================================================================

ColorScheme automotiveLightScheme() {
  return ColorScheme(
    brightness: Brightness.light,
    primary: racingBlue,
    onPrimary: Colors.white,
    primaryContainer: electricBlue.withValues(alpha: 0.12),
    onPrimaryContainer: racingBlue,
    secondary: racingGreen,
    onSecondary: Colors.white,
    secondaryContainer: racingGreen.withValues(alpha: 0.12),
    onSecondaryContainer: const Color(0xFF065F46),
    tertiary: racingAmber,
    onTertiary: midnightBlue,
    tertiaryContainer: racingAmber.withValues(alpha: 0.14),
    onTertiaryContainer: const Color(0xFF92400E),
    error: racingRed,
    onError: Colors.white,
    errorContainer: racingRed.withValues(alpha: 0.12),
    onErrorContainer: const Color(0xFF991B1B),
    surface: cream,
    onSurface: navy,
    surfaceContainerLowest: Colors.white,
    surfaceContainerLow: Colors.white,
    surfaceContainer: const Color(0xFFF1F5F9),
    surfaceContainerHigh: const Color(0xFFEDF2F7),
    surfaceContainerHighest: const Color(0xFFE7EDF4),
    onSurfaceVariant: slate,
    outline: const Color(0xFFCBD5E1),
    outlineVariant: const Color(0xFFE2E8F0),
    shadow: const Color(0xFF0F172A),
    scrim: const Color(0x66000000),
    inverseSurface: midnightBlue,
    onInverseSurface: cream,
    inversePrimary: const Color(0xFF93C5FD),
  );
}

ColorScheme automotiveDarkScheme() {
  return ColorScheme(
    brightness: Brightness.dark,
    primary: electricBlue,
    onPrimary: cream,
    primaryContainer: electricBlue.withValues(alpha: 0.22),
    onPrimaryContainer: const Color(0xFFBFDBFE),
    secondary: racingGreen,
    onSecondary: limeAccent,
    secondaryContainer: racingGreen.withValues(alpha: 0.2),
    onSecondaryContainer: const Color(0xFFA7F3D0),
    tertiary: racingAmber,
    onTertiary: const Color(0xFF1E293B),
    tertiaryContainer: racingAmber.withValues(alpha: 0.2),
    onTertiaryContainer: const Color(0xFFFDE68A),
    error: racingRed,
    onError: Colors.white,
    errorContainer: racingRed.withValues(alpha: 0.22),
    onErrorContainer: const Color(0xFFFECACA),
    surface: midnightBlue,
    onSurface: cream,
    surfaceContainerLowest: royalBlue,
    surfaceContainerLow: const Color(0xFF171733),
    surfaceContainer: const Color(0xFF1B1B3A),
    surfaceContainerHigh: midnight,
    surfaceContainerHighest: const Color(0xFF263449),
    onSurfaceVariant: const Color(0xFF94A3B8),
    outline: const Color(0xFF334155),
    outlineVariant: const Color(0xFF1E293B),
    shadow: Colors.black,
    scrim: const Color(0x99000000),
    inverseSurface: cream,
    onInverseSurface: midnightBlue,
    inversePrimary: racingBlue,
  );
}

ColorScheme automotiveNightScheme() {
  return ColorScheme(
    brightness: Brightness.dark,
    primary: racingPurple,
    onPrimary: limeAccent,
    primaryContainer: racingPurple.withValues(alpha: 0.22),
    onPrimaryContainer: const Color(0xFFDDD6FE),
    secondary: orangePulse,
    onSecondary: midnightBlue,
    secondaryContainer: orangePulse.withValues(alpha: 0.2),
    onSecondaryContainer: const Color(0xFFFED7AA),
    tertiary: racingYellow,
    onTertiary: midnightBlue,
    tertiaryContainer: racingYellow.withValues(alpha: 0.2),
    onTertiaryContainer: const Color(0xFFFEF3C7),
    error: racingRed,
    onError: Colors.white,
    errorContainer: racingRed.withValues(alpha: 0.22),
    onErrorContainer: const Color(0xFFFECACA),
    surface: royalBlue,
    onSurface: cream,
    surfaceContainerLowest: const Color(0xFF07071A),
    surfaceContainerLow: const Color(0xFF131330),
    surfaceContainer: const Color(0xFF181838),
    surfaceContainerHigh: const Color(0xFF1F1F44),
    surfaceContainerHighest: const Color(0xFF262651),
    onSurfaceVariant: const Color(0xFF94A3B8),
    outline: const Color(0xFF3B3B6B),
    outlineVariant: const Color(0xFF1E1E45),
    shadow: Colors.black,
    scrim: const Color(0x99000000),
    inverseSurface: cream,
    onInverseSurface: royalBlue,
    inversePrimary: racingGreen,
  );
}

// ============================================================================
// TYPOGRAPHY
// ============================================================================

/// Builds a scheme-aware text theme.
///
/// [variant] selects the palette (light / dark / night) so text colors always
/// match the active brightness instead of being hardcoded.
TextTheme automotiveTextTheme(ColorScheme scheme) {
  final strong = scheme.onSurface;
  final soft = scheme.onSurfaceVariant;
  final accent = scheme.primary;

  TextStyle s(
    double size,
    FontWeight weight, {
    double spacing = 0,
    Color? color,
    double? height,
  }) => TextStyle(
    fontSize: size,
    fontWeight: weight,
    letterSpacing: spacing,
    color: color ?? strong,
    height: height,
  );

  return TextTheme(
    displayLarge: s(52, FontWeight.w800, spacing: -1.5, height: 1.05),
    displayMedium: s(42, FontWeight.w800, spacing: -1, height: 1.1),
    displaySmall: s(34, FontWeight.w700, spacing: -0.5, height: 1.15),
    headlineLarge: s(30, FontWeight.w800, spacing: -0.6, height: 1.2),
    headlineMedium: s(26, FontWeight.w700, spacing: -0.4, height: 1.2),
    headlineSmall: s(22, FontWeight.w700, spacing: -0.2, height: 1.25),
    titleLarge: s(20, FontWeight.w700, height: 1.3),
    titleMedium: s(16, FontWeight.w700, spacing: 0.1, height: 1.35),
    titleSmall: s(14, FontWeight.w700, spacing: 0.1, color: soft, height: 1.35),
    bodyLarge: s(16, FontWeight.w400, spacing: 0.2, height: 1.5),
    bodyMedium: s(14, FontWeight.w400, spacing: 0.2, color: soft, height: 1.5),
    bodySmall: s(12, FontWeight.w400, spacing: 0.3, color: soft, height: 1.45),
    labelLarge: s(15, FontWeight.w700, color: accent, height: 1.2),
    labelMedium: s(12, FontWeight.w700, spacing: 0.6, color: soft, height: 1.2),
    labelSmall: s(11, FontWeight.w700, spacing: 0.6, color: soft, height: 1.2),
  );
}

// ============================================================================
// THEME BUILDERS
// ============================================================================

/// Composes a full [ThemeData] from a [ColorScheme].
///
/// Shared by every theme variant so component theming (cards, inputs,
/// buttons, nav bar) is defined exactly once.
ThemeData buildThemeData(ColorScheme scheme) {
  final isDark = scheme.brightness == Brightness.dark;
  final textTheme = automotiveTextTheme(scheme);

  final base = ThemeData(
    useMaterial3: true,
    colorScheme: scheme,
    textTheme: textTheme,
    scaffoldBackgroundColor: scheme.surface,
    canvasColor: scheme.surface,
    splashFactory: InkSparkle.splashFactory,
  );

  return base.copyWith(
    textTheme: textTheme,

    // ---- AppBar -----------------------------------------------------------
    appBarTheme: AppBarTheme(
      backgroundColor: scheme.surface,
      foregroundColor: scheme.onSurface,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: false,
      titleTextStyle: textTheme.titleLarge,
      systemOverlayStyle: isDark
          ? SystemUiOverlayStyle.light
          : SystemUiOverlayStyle.dark,
    ),

    // ---- Cards ------------------------------------------------------------
    cardTheme: CardThemeData(
      color: scheme.surfaceContainerLow,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.card),
      ),
    ),

    // ---- Inputs -----------------------------------------------------------
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: isDark
          ? scheme.surfaceContainerHigh
          : scheme.surfaceContainerLow,
      contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
      floatingLabelBehavior: FloatingLabelBehavior.auto,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppRadius.input),
        borderSide: BorderSide(color: scheme.outline),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppRadius.input),
        borderSide: BorderSide(color: scheme.outline),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppRadius.input),
        borderSide: BorderSide(color: scheme.primary, width: 1.6),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppRadius.input),
        borderSide: BorderSide(color: scheme.error),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppRadius.input),
        borderSide: BorderSide(color: scheme.error, width: 1.6),
      ),
      labelStyle: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
      floatingLabelStyle: textTheme.bodyMedium?.copyWith(
        color: scheme.primary,
        fontWeight: FontWeight.w700,
      ),
      hintStyle: textTheme.bodyMedium?.copyWith(
        color: scheme.onSurfaceVariant.withValues(alpha: 0.7),
      ),
      prefixIconColor: scheme.onSurfaceVariant,
      suffixIconColor: scheme.onSurfaceVariant,
    ),

    // ---- Dropdowns -------------------------------------------------------
    dropdownMenuTheme: DropdownMenuThemeData(
      textStyle: textTheme.bodyLarge,
      menuStyle: MenuStyle(
        backgroundColor: WidgetStatePropertyAll(scheme.surfaceContainerHigh),
        surfaceTintColor: const WidgetStatePropertyAll(Colors.transparent),
        elevation: const WidgetStatePropertyAll(4),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.input),
            side: BorderSide(color: scheme.outlineVariant),
          ),
        ),
      ),
    ),

    // ---- Buttons ----------------------------------------------------------
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        minimumSize: const Size(0, 52),
        padding: const EdgeInsets.symmetric(horizontal: 24),
        textStyle: textTheme.labelLarge?.copyWith(
          fontSize: 15,
          fontWeight: FontWeight.w800,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.button),
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        minimumSize: const Size(0, 52),
        padding: const EdgeInsets.symmetric(horizontal: 24),
        side: BorderSide(color: scheme.outline),
        textStyle: textTheme.labelLarge?.copyWith(
          fontSize: 15,
          fontWeight: FontWeight.w800,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.button),
        ),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        textStyle: textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w700),
      ),
    ),
    iconButtonTheme: IconButtonThemeData(
      style: IconButton.styleFrom(
        foregroundColor: scheme.onSurfaceVariant,
        highlightColor: scheme.primary.withValues(alpha: 0.10),
      ),
    ),

    // ---- Navigation -------------------------------------------------------
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: scheme.surface,
      surfaceTintColor: Colors.transparent,
      indicatorColor: scheme.primary.withValues(alpha: 0.16),
      elevation: 0,
      labelTextStyle: WidgetStatePropertyAll(
        textTheme.labelSmall?.copyWith(fontWeight: FontWeight.w700),
      ),
    ),

    // ---- Sheets / dialogs -------------------------------------------------
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: scheme.surfaceContainerLow,
      surfaceTintColor: Colors.transparent,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppRadius.sheet),
        ),
      ),
      showDragHandle: true,
      dragHandleColor: scheme.outline,
    ),
    dialogTheme: DialogThemeData(
      backgroundColor: scheme.surfaceContainerLow,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.card),
      ),
    ),

    // ---- Misc -------------------------------------------------------------
    dividerTheme: DividerThemeData(
      color: scheme.outlineVariant,
      thickness: 1,
      space: 1,
    ),
    chipTheme: ChipThemeData(
      backgroundColor: scheme.surfaceContainerHigh,
      side: BorderSide(color: scheme.outlineVariant),
      labelStyle: textTheme.labelMedium,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.badge),
      ),
    ),
    snackBarTheme: SnackBarThemeData(
      behavior: SnackBarBehavior.floating,
      backgroundColor: scheme.inverseSurface,
      contentTextStyle: textTheme.bodyMedium?.copyWith(
        color: scheme.onInverseSurface,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.button),
      ),
    ),
    listTileTheme: ListTileThemeData(
      iconColor: scheme.onSurfaceVariant,
      titleTextStyle: textTheme.titleSmall?.copyWith(
        color: scheme.onSurface,
        fontWeight: FontWeight.w600,
      ),
      subtitleTextStyle: textTheme.bodySmall,
    ),
    progressIndicatorTheme: ProgressIndicatorThemeData(
      color: scheme.primary,
      linearTrackColor: scheme.surfaceContainerHighest,
    ),
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: {
        TargetPlatform.android: PredictiveBackPageTransitionsBuilder(),
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      },
    ),
  );
}

/// Light theme (a.k.a. `white` preference).
ThemeData buildLightTheme() => buildThemeData(automotiveLightScheme());

/// Dark theme (a.k.a. `black` preference).
ThemeData buildDarkTheme() => buildThemeData(automotiveDarkScheme());

/// Night theme (a.k.a. `nightOwl` preference) — purple, higher contrast.
ThemeData buildNightTheme() => buildThemeData(automotiveNightScheme());
