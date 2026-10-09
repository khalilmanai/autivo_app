import '../../../data/models/catalog.dart';

/// The vehicle the user committed to in the catalog, returned to the Add Car
/// form via `Navigator.pop`.
///
/// Only fields the Add Car form can actually accept are carried. The form has
/// no drivetrain or body-class input, so those are deliberately absent rather
/// than silently dropped later.
class CatalogVehicleSelection {
  final String make;
  final String model;
  final int year;

  /// Already normalized to the Add Car form's fuel-type option values, so the
  /// form can assign it directly. `null` when the catalog value did not map.
  final String? fuelType;

  /// Already normalized to the Add Car form's transmission option values.
  /// `null` when the catalog value did not map.
  final String? transmission;

  /// Human-readable engine summary, e.g. "1.5L Turbo I-4 (166 HP)".
  final String? engine;

  /// How many engines the catalog knows about for this year. The form only
  /// has a single free-text field, so when this is greater than one the UI
  /// should say which one was picked rather than imply it is the only option.
  final int engineCount;

  const CatalogVehicleSelection({
    required this.make,
    required this.model,
    required this.year,
    this.fuelType,
    this.transmission,
    this.engine,
    this.engineCount = 0,
  });
}

/// Derives the selection from already-loaded catalog data.
///
/// Pure and top-level so it can be unit-tested without a widget tree.
CatalogVehicleSelection buildCatalogSelection({
  required String make,
  required String model,
  required int year,
  List<EngineConfig> engines = const [],
  List<TransmissionConfig> transmissions = const [],
}) {
  final primary = engines.isEmpty ? null : engines.first;

  return CatalogVehicleSelection(
    make: make,
    model: model,
    year: year,
    // Engines describe the fuel the vehicle burns, so they are the better
    // source than the transmission.
    fuelType: primary == null
        ? null
        : normalizeFuelType(primary.fuelType),
    transmission: transmissions.isEmpty
        ? null
        : normalizeTransmission(transmissions.first.type),
    engine: primary == null ? null : engineLabel(primary),
    engineCount: engines.length,
  );
}

/// Lowercases and strips everything that is not a letter or digit, so
/// "Dual-Clutch", "dual clutch" and "DUAL_CLUTCH" all collapse together.
///
/// If the input has no ASCII alphanumerics at all (an untranslated value), the
/// trimmed original is returned so a non-empty key is still produced.
String normalizeToken(String? input) {
  final raw = (input ?? '').trim().toLowerCase();
  final buffer = StringBuffer();
  for (final rune in raw.runes) {
    final char = String.fromCharCode(rune);
    final isDigit = rune >= 0x30 && rune <= 0x39;
    final isLower = rune >= 0x61 && rune <= 0x7a;
    if (isDigit || isLower) buffer.write(char);
  }
  return buffer.isEmpty ? raw : buffer.toString();
}

bool _containsAny(String key, Set<String> tokens) =>
    tokens.any((token) => key.contains(token));

/// Maps a catalog fuel type onto one of the Add Car form's values:
/// `gasoline`, `diesel`, `electric`, `hybrid`, `flex_fuel`.
///
/// Returns `null` for anything unrecognised so the caller can leave the form's
/// own default in place rather than writing a value the dropdown cannot show.
String? normalizeFuelType(String? raw) {
  final key = normalizeToken(raw);
  if (key.isEmpty) return null;
  final exact = _exactFuelTypes[key];
  if (exact != null) return exact;

  // Most specific first: a plug-in hybrid can run on gasoline, so it belongs
  // under `hybrid` and not `electric`.
  // Flex fuel before the other checks: catalog data often labels these engines
  // "Gasoline" or "Mild Hybrid" with a separate flex/E85 designation, so a
  // later match would swallow the more specific answer.
  if (_containsAny(key, _flexFuelTokens)) return 'flex_fuel';
  if (_containsAny(key, _phevTokens)) return 'hybrid';
  if (_containsAny(key, _electricTokens)) return 'electric';
  if (_containsAny(key, _hybridTokens)) return 'hybrid';
  if (_containsAny(key, _dieselTokens)) return 'diesel';
  if (_containsAny(key, _gasolineTokens)) return 'gasoline';
  return null;
}

/// Maps a catalog transmission type onto one of the Add Car form's values:
/// `manual`, `automatic`, `cvt`, `dct`.
String? normalizeTransmission(String? raw) {
  final key = normalizeToken(raw);
  if (key.isEmpty) return null;
  final exact = _exactTransmissionTypes[key];
  if (exact != null) return exact;

  // Before `automatic`, because a DCT and a CVT are both automated but the
  // form offers them as separate choices.
  if (_containsAny(key, _cvtTokens)) return 'cvt';
  if (_containsAny(key, _dctTokens)) return 'dct';
  if (_containsAny(key, _manualTokens)) return 'manual';
  if (_containsAny(key, _automaticTokens)) return 'automatic';
  return null;
}

/// Builds the engine summary shown on the Add Car form.
String? engineLabel(EngineConfig engine) {
  final figures = <String>[];
  if (engine.displacementCc > 0) {
    figures.add('${(engine.displacementCc / 1000).toStringAsFixed(1)}L');
  }
  if (engine.cylinders > 0) figures.add('${engine.cylinders} cyl');
  if (engine.powerHp > 0) figures.add('${engine.powerHp} HP');

  final name = engine.name.trim();
  if (figures.isEmpty) return name.isEmpty ? null : name;
  final summary = figures.join(' • ');
  return name.isEmpty ? summary : '$name ($summary)';
}

const Map<String, String> _exactFuelTypes = <String, String>{
  'gas': 'gasoline',
  'petrol': 'gasoline',
  'gasoline': 'gasoline',
  'essence': 'gasoline',
  'benzin': 'gasoline',
  'benzine': 'gasoline',
  'diesel': 'diesel',
  'gasoil': 'diesel',
  'ev': 'electric',
  'bev': 'electric',
  'electric': 'electric',
  'hev': 'hybrid',
  'hybrid': 'hybrid',
  'phev': 'hybrid',
  'flexfuel': 'flex_fuel',
  'flex': 'flex_fuel',
  'e85': 'flex_fuel',
};

const Map<String, String> _exactTransmissionTypes = <String, String>{
  'manual': 'manual',
  'mt': 'manual',
  'stick': 'manual',
  'auto': 'automatic',
  'at': 'automatic',
  'automatic': 'automatic',
  'tiptronic': 'automatic',
  'cvt': 'cvt',
  'dct': 'dct',
  'dsg': 'dct',
  'stronic': 'dct',
  'dualclutch': 'dct',
};

const Set<String> _flexFuelTokens = <String>{
  'flexfuel',
  'flex',
  'e85',
  'e85gasoline',
};
const Set<String> _phevTokens = <String>{'phev', 'plugin', 'pluginhybrid'};
const Set<String> _electricTokens = <String>{'electric', 'bev', 'battery'};
const Set<String> _hybridTokens = <String>{'hybrid', 'hev', 'mildhybrid'};
const Set<String> _dieselTokens = <String>{'diesel', 'gasoil'};
const Set<String> _gasolineTokens = <String>{
  'gasoline',
  'petrol',
  'gas',
  'essence',
  'benzin',
};

const Set<String> _cvtTokens = <String>{'cvt', 'continuouslyvariable'};
const Set<String> _dctTokens = <String>{
  'dct',
  'dualclutch',
  'dsg',
  'stronic',
};
const Set<String> _manualTokens = <String>{'manual', 'manuellgetrieb'};
const Set<String> _automaticTokens = <String>{
  'automatic',
  'tiptronic',
  'aisin',
  'torqueconverter',
};
