import 'package:autivo/core/constants/app_constants.dart';
import 'package:autivo/core/utils/formatters.dart';
import 'package:autivo/data/models/vin_decode.dart';
import 'package:flutter_test/flutter_test.dart';

/// Mirrors the non-nullable fields the app casts from the decode response.
/// The backend returns every one of these; the test fails if the app's model
/// grows a non-nullable field the server does not send.
const _serverDecodedFields = <String>{
  'make',
  'model',
  'year',
  'fuelType',
  'fuelLabel',
  'transmission',
  'bodyClass',
  'trim',
  'drivetrain',
  'plantCountry',
  'engineCylinders',
  'engineHP',
  'doors',
  'engineConfiguration',
  'engineDisplacementL',
  'transmissionSpeeds',
  'valveTrainDesign',
  'plantCity',
  'plantState',
  'manufacturer',
  'vehicleType',
  'batteryKWh',
  'electrificationLevel',
  'engineKw',
  'displacementCc',
};

/// Mirrors what `CarApi.decodeVin` builds: the top-level decode fields merged
/// with the nested `decoded` object, exactly as the app flattens them.
Map<String, dynamic> _decodeResponse({
  String fuelType = 'gasoline',
  String? batteryKWh,
  String? electrificationLevel,
  num engineKw = 224,
  num displacementCc = 2979,
  Map<String, dynamic>? decodedOverrides,
}) {
  final decoded = <String, dynamic>{
    'make': 'BMW',
    'model': 'X3',
    'year': 2011,
    'fuelType': fuelType,
    'fuelLabel': 'Gasoline',
    'transmission': 'Automatic',
    'bodyClass': 'SUV',
    'trim': 'xDrive35i',
    'drivetrain': 'AWD',
    'plantCountry': 'GERMANY',
    'engineCylinders': '6',
    'engineHP': '300',
    'doors': '4',
    'engineConfiguration': '',
    'engineDisplacementL': '3.0',
    'transmissionSpeeds': '8',
    'valveTrainDesign': 'DOHC',
    'plantCity': 'MUNICH',
    'plantState': '',
    'manufacturer': 'BMW',
    'vehicleType': 'MPV',
    'batteryKWh': batteryKWh,
    'electrificationLevel': electrificationLevel,
    'engineKw': engineKw,
    'displacementCc': displacementCc,
    ...?decodedOverrides,
  };

  return <String, dynamic>{
    'vin': '5UXWX7C5XBA111111',
    'decoded': decoded,
    'missingFields': <String>[],
    'suggestions': <String, dynamic>{},
    'source': 'nhtsa',
    'confidence': 'HIGH',
  };
}

/// Applies the same flatten the API layer performs before `fromJson`.
Map<String, dynamic> _flattened(Map<String, dynamic> response) {
  final decoded = response['decoded'];
  if (decoded is Map) {
    return <String, dynamic>{...response, ...decoded};
  }
  return response;
}

void main() {
  group('VinDecodeResult', () {
    test('parses a full decode response with every field present', () {
      final result = VinDecodeResult.fromJson(_flattened(_decodeResponse()));

      expect(result.make, 'BMW');
      expect(result.doors, '4');
      expect(result.plantCity, 'MUNICH');
      expect(result.manufacturer, 'BMW');
      expect(result.vehicleType, 'MPV');
      expect(result.engineDisplacementL, '3.0');
      expect(result.transmissionSpeeds, '8');
      expect(result.valveTrainDesign, 'DOHC');
    });

    test('parses a response whose optional electric fields are null', () {
      final result = VinDecodeResult.fromJson(_flattened(_decodeResponse()));

      expect(result.batteryKWh, isNull);
      expect(result.electrificationLevel, isNull);
      expect(result.engineKw, 224);
      expect(result.displacementCc, 2979);
    });

    test('parses a response that omits the electric fields entirely', () {
      final response = _decodeResponse(
        decodedOverrides: const <String, dynamic>{},
      );
      (response['decoded'] as Map<String, dynamic>)
        ..remove('batteryKWh')
        ..remove('electrificationLevel')
        ..remove('engineKw')
        ..remove('displacementCc');

      final result = VinDecodeResult.fromJson(_flattened(response));

      expect(result.batteryKWh, isNull);
      expect(result.electrificationLevel, isNull);
      expect(result.engineKw, 0);
      expect(result.displacementCc, 0);
    });

    test('parses an electric decode with battery details', () {
      final result = VinDecodeResult.fromJson(
        _flattened(
          _decodeResponse(
            fuelType: 'electric',
            batteryKWh: '75',
            electrificationLevel: 'BEV',
            engineKw: 0,
            displacementCc: 0,
          ),
        ),
      );

      expect(result.fuelType, 'electric');
      expect(result.batteryKWh, '75');
      expect(result.electrificationLevel, 'BEV');
    });

    test('the test fixture covers every field the server sends', () {
      final decoded = _decodeResponse()['decoded'] as Map<String, dynamic>;
      expect(decoded.keys.toSet(), containsAll(_serverDecodedFields));
    });
  });

  group('FuelTypes', () {
    test('offers flex fuel as a selectable option', () {
      expect(FuelTypes.values, contains('flex_fuel'));
      expect(FuelTypes.labels['flex_fuel'], 'Flex Fuel');
    });
  });

  group('getFuelTypeLabel', () {
    test('localizes flex fuel in every supported language', () {
      expect(getFuelTypeLabel('flex_fuel'), 'Flex Fuel');
      expect(getFuelTypeLabel('flex_fuel', locale: 'fr'), 'Carburant flexible');
      expect(getFuelTypeLabel('flex_fuel', locale: 'ar'), 'وقود مرن');
    });
  });
}
