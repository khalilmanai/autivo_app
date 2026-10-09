// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vin_decode.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VinSuggestion _$VinSuggestionFromJson(Map<String, dynamic> json) =>
    VinSuggestion(
      name: json['name'] as String,
      detail: json['detail'] as String?,
    );

Map<String, dynamic> _$VinSuggestionToJson(VinSuggestion instance) =>
    <String, dynamic>{'name': instance.name, 'detail': instance.detail};

VinDecodeResult _$VinDecodeResultFromJson(Map<String, dynamic> json) =>
    VinDecodeResult(
      vin: json['vin'] as String,
      make: json['make'] as String,
      model: json['model'] as String,
      year: (json['year'] as num).toInt(),
      fuelType: json['fuelType'] as String,
      fuelLabel: json['fuelLabel'] as String,
      transmission: json['transmission'] as String,
      bodyClass: json['bodyClass'] as String,
      engineCylinders: json['engineCylinders'] as String,
      engineHP: json['engineHP'] as String,
      plantCountry: json['plantCountry'] as String,
      trim: json['trim'] as String,
      drivetrain: json['drivetrain'] as String,
      doors: json['doors'] as String,
      engineConfiguration: json['engineConfiguration'] as String,
      engineDisplacementL: json['engineDisplacementL'] as String,
      transmissionSpeeds: json['transmissionSpeeds'] as String,
      valveTrainDesign: json['valveTrainDesign'] as String,
      plantCity: json['plantCity'] as String,
      plantState: json['plantState'] as String,
      manufacturer: json['manufacturer'] as String,
      vehicleType: json['vehicleType'] as String,
      batteryKWh: json['batteryKWh'] as String?,
      electrificationLevel: json['electrificationLevel'] as String?,
      engineKw: json['engineKw'] as num? ?? 0,
      displacementCc: json['displacementCc'] as num? ?? 0,
      missingFields: (json['missingFields'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      suggestions: (json['suggestions'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(
          k,
          (e as List<dynamic>)
              .map((e) => VinSuggestion.fromJson(e as Map<String, dynamic>))
              .toList(),
        ),
      ),
      source: json['source'] as String,
      confidence: json['confidence'] as String,
    );

Map<String, dynamic> _$VinDecodeResultToJson(VinDecodeResult instance) =>
    <String, dynamic>{
      'vin': instance.vin,
      'make': instance.make,
      'model': instance.model,
      'year': instance.year,
      'fuelType': instance.fuelType,
      'fuelLabel': instance.fuelLabel,
      'transmission': instance.transmission,
      'bodyClass': instance.bodyClass,
      'engineCylinders': instance.engineCylinders,
      'engineHP': instance.engineHP,
      'plantCountry': instance.plantCountry,
      'trim': instance.trim,
      'drivetrain': instance.drivetrain,
      'doors': instance.doors,
      'engineConfiguration': instance.engineConfiguration,
      'engineDisplacementL': instance.engineDisplacementL,
      'transmissionSpeeds': instance.transmissionSpeeds,
      'valveTrainDesign': instance.valveTrainDesign,
      'plantCity': instance.plantCity,
      'plantState': instance.plantState,
      'manufacturer': instance.manufacturer,
      'vehicleType': instance.vehicleType,
      'batteryKWh': instance.batteryKWh,
      'electrificationLevel': instance.electrificationLevel,
      'engineKw': instance.engineKw,
      'displacementCc': instance.displacementCc,
      'missingFields': instance.missingFields,
      'suggestions': instance.suggestions,
      'source': instance.source,
      'confidence': instance.confidence,
    };

DecodeVinRequest _$DecodeVinRequestFromJson(Map<String, dynamic> json) =>
    DecodeVinRequest(vin: json['vin'] as String);

Map<String, dynamic> _$DecodeVinRequestToJson(DecodeVinRequest instance) =>
    <String, dynamic>{'vin': instance.vin};
