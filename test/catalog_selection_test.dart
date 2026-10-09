import 'package:autivo/data/models/catalog.dart';
import 'package:autivo/presentation/views/catalog/catalog_selection.dart';
import 'package:autivo/presentation/views/garage/catalog_prefill.dart';
import 'package:flutter_test/flutter_test.dart';

const _engine = EngineConfig(
  name: '1.5L Turbo',
  displacementCc: 1498,
  cylinders: 4,
  powerHp: 181,
  fuelType: 'Gasoline',
);

void main() {
  group('normalizeToken', () {
    test('lowercases and strips separators', () {
      expect(normalizeToken('Dual-Clutch'), 'dualclutch');
      expect(normalizeToken('  A T   '), 'at');
      expect(normalizeToken('CVT-8'), 'cvt8');
    });

    test('returns a non-empty key for untranslatable input', () {
      expect(normalizeToken('ناقل'), isNotEmpty);
      expect(normalizeToken(null), isEmpty);
    });
  });

  group('normalizeFuelType', () {
    test('maps the form values to themselves', () {
      expect(normalizeFuelType('gasoline'), 'gasoline');
      expect(normalizeFuelType('diesel'), 'diesel');
        expect(normalizeFuelType('electric'), 'electric');
        expect(normalizeFuelType('hybrid'), 'hybrid');
        expect(normalizeFuelType('flex_fuel'), 'flex_fuel');
      });

    test('maps regional synonyms onto the form value', () {
      expect(normalizeFuelType('Petrol'), 'gasoline');
      expect(normalizeFuelType('Essence'), 'gasoline');
      expect(normalizeFuelType('Gasoline'), 'gasoline');
      expect(normalizeFuelType('Diesel'), 'diesel');
    });

    test('treats a plug-in hybrid as hybrid, not electric', () {
      // A PHEV can run on gasoline, which is what the form needs to know.
      expect(normalizeFuelType('PHEV'), 'hybrid');
      expect(normalizeFuelType('Plug-in Hybrid'), 'hybrid');
      expect(normalizeFuelType('Mild Hybrid'), 'hybrid');
    });

    test('maps battery-only values to electric', () {
      expect(normalizeFuelType('BEV'), 'electric');
      expect(normalizeFuelType('Battery Electric'), 'electric');
    });

    test('maps flex-fuel values to flex_fuel', () {
      expect(normalizeFuelType('Flex Fuel'), 'flex_fuel');
      expect(normalizeFuelType('E85'), 'flex_fuel');
      expect(normalizeFuelType('E85 Gasoline'), 'flex_fuel');
    });

    test('prefers flex_fuel over gasoline and hybrid on mixed labels', () {
      // vPIC and catalog data often label a flex-fuel engine "Gasoline" or
      // "Mild Hybrid" alongside a flex designation, and the more specific
      // answer has to win.
      expect(normalizeFuelType('Gasoline Flex Fuel'), 'flex_fuel');
      expect(normalizeFuelType('Mild Hybrid E85'), 'flex_fuel');
    });

    test('finds the fuel inside a longer description', () {
      expect(normalizeFuelType('1.5L Turbo Petrol'), 'gasoline');
      expect(normalizeFuelType('2.0L Turbo Diesel'), 'diesel');
    });

    test('returns null for anything unrecognised', () {
      // null means "leave the form's own default", never a bad dropdown value.
      expect(normalizeFuelType('LPG'), isNull);
      expect(normalizeFuelType('Rotary'), isNull);
      expect(normalizeFuelType(''), isNull);
      expect(normalizeFuelType(null), isNull);
    });
  });

  group('normalizeTransmission', () {
    test('maps the form values to themselves', () {
      expect(normalizeTransmission('manual'), 'manual');
      expect(normalizeTransmission('automatic'), 'automatic');
      expect(normalizeTransmission('cvt'), 'cvt');
      expect(normalizeTransmission('dct'), 'dct');
    });

    test('prefers dct and cvt over automatic', () {
      // Both are automated, but the form offers them separately, so the more
      // specific classification has to win.
      expect(normalizeTransmission('Dual-Clutch'), 'dct');
      expect(normalizeTransmission('DSG'), 'dct');
      expect(normalizeTransmission('S-Tronic'), 'dct');
      expect(normalizeTransmission('Continuously Variable'), 'cvt');
    });

    test('maps common automatic aliases', () {
      expect(normalizeTransmission('Auto'), 'automatic');
      expect(normalizeTransmission('Tiptronic'), 'automatic');
    });

    test('returns null for anything unrecognised', () {
      expect(normalizeTransmission('Preselector'), isNull);
      expect(normalizeTransmission(''), isNull);
      expect(normalizeTransmission(null), isNull);
    });

    test('maps a torque converter to automatic', () {
      expect(normalizeTransmission('Torque Converter'), 'automatic');
    });
  });

  group('engineLabel', () {
    test('combines the name with the key figures', () {
      expect(engineLabel(_engine), '1.5L Turbo (1.5L • 4 cyl • 181 HP)');
    });

    test('falls back to the figures when there is no name', () {
      const unnamed = EngineConfig(
        name: '   ',
        displacementCc: 2000,
        cylinders: 4,
        powerHp: 150,
        fuelType: 'Gasoline',
      );

      expect(engineLabel(unnamed), '2.0L • 4 cyl • 150 HP');
    });

    test('omits zero and negative figures', () {
      const sparse = EngineConfig(
        name: 'Base',
        displacementCc: 0,
        cylinders: 0,
        powerHp: 0,
        fuelType: 'Gasoline',
      );

      expect(engineLabel(sparse), 'Base');
    });
  });

  group('buildCatalogSelection', () {
    test('derives normalized values from the loaded data', () {
      final selection = buildCatalogSelection(
        make: 'Honda',
        model: 'Civic',
        year: 2020,
        engines: const [_engine],
        transmissions: const [
          TransmissionConfig(name: 'CVT', type: 'CVT', gears: 7),
        ],
      );

      expect(selection.make, 'Honda');
      expect(selection.model, 'Civic');
      expect(selection.year, 2020);
      expect(selection.fuelType, 'gasoline');
      expect(selection.transmission, 'cvt');
      expect(selection.engine, isNotNull);
      expect(selection.engineCount, 1);
    });

    test('leaves unmappable fields null instead of guessing', () {
      const oddEngine = EngineConfig(
        name: 'Wankel',
        displacementCc: 1149,
        cylinders: 0,
        powerHp: 205,
        fuelType: 'Rotary',
      );
      final selection = buildCatalogSelection(
        make: 'Mazda',
        model: 'RX-7',
        year: 1989,
        engines: const [oddEngine],
        transmissions: const [
          TransmissionConfig(name: 'Manual', type: 'Manual', gears: 5),
        ],
      );

      expect(selection.fuelType, isNull);
      expect(selection.transmission, 'manual');
    });

    test('survives having no engines or transmissions at all', () {
      final selection = buildCatalogSelection(
        make: 'Honda',
        model: 'Civic',
        year: 2020,
      );

      expect(selection.fuelType, isNull);
      expect(selection.transmission, isNull);
      expect(selection.engine, isNull);
      expect(selection.engineCount, 0);
    });
  });

  group('computeCarPrefill', () {
    final selection = buildCatalogSelection(
      make: 'Honda',
      model: 'Civic',
      year: 2020,
      engines: const [_engine],
      transmissions: const [
        TransmissionConfig(name: 'CVT', type: 'CVT', gears: 7),
      ],
    );

    CarFormPrefill prefill({
      String make = '',
      String model = '',
      String year = '',
      String engine = '',
      String fuelType = 'gasoline',
      String transmission = 'manual',
      bool fuelTypeLocked = false,
      bool transmissionLocked = false,
      CatalogVehicleSelection? selectionOverride,
    }) => computeCarPrefill(
      selection: selectionOverride ?? selection,
      currentMake: make,
      currentModel: model,
      currentYear: year,
      currentEngine: engine,
      currentFuelType: fuelType,
      currentTransmission: transmission,
      fuelTypeLocked: fuelTypeLocked,
      transmissionLocked: transmissionLocked,
    );

    test('fills an empty form', () {
      final result = prefill();

      expect(result.make, 'Honda');
      expect(result.model, 'Civic');
      expect(result.year, '2020');
      expect(result.fuelType, 'gasoline');
      expect(result.transmission, 'cvt');
      expect(result.engine, isNotNull);
    });

    test('never overwrites text the user already typed', () {
      final result = prefill(
        make: 'Toyota',
        model: 'Camry',
        year: '2018',
        engine: 'Mine',
      );

      expect(result.make, isNull);
      expect(result.model, isNull);
      expect(result.year, isNull);
      expect(result.engine, isNull);
    });

    test('treats whitespace-only input as empty', () {
      final result = prefill(make: '   ', year: ' ');

      expect(result.make, 'Honda');
      expect(result.year, '2020');
    });

    test('respects a dropdown the user has already chosen', () {
      final result = prefill(
        fuelType: 'diesel',
        fuelTypeLocked: true,
        transmission: 'dct',
        transmissionLocked: true,
      );

      expect(result.fuelType, isNull);
      expect(result.transmission, isNull);
    });

    test('leaves a dropdown alone when the catalog value did not map', () {
      // An unmapped value must not become a value the dropdown cannot show.
      final unmapped = CatalogVehicleSelection(
        make: 'Mazda',
        model: 'RX-7',
        year: 1989,
        transmission: 'manual',
      );
      final result = prefill(selectionOverride: unmapped);

      expect(result.fuelType, isNull);
      expect(result.transmission, 'manual');
    });
  });
}
