// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'catalog.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VehicleSpec _$VehicleSpecFromJson(Map<String, dynamic> json) => VehicleSpec(
  uuid: json['uuid'] as String,
  make: json['make'] as String,
  model: json['model'] as String,
  year: (json['year'] as num).toInt(),
  trim: json['trim'] as String,
  body: json['body'] as String,
  driveType: json['driveType'] as String,
  fuelType: json['fuelType'] as String,
  transmission: json['transmission'] as String,
  epaClass: json['epaClass'] as String,
  engineCylinders: (json['engineCylinders'] as num?)?.toInt(),
  engineCc: (json['engineCc'] as num?)?.toInt(),
  numDoors: (json['numDoors'] as num?)?.toInt(),
  mpgCity: (json['mpgCity'] as num?)?.toInt(),
  mpgHighway: (json['mpgHighway'] as num?)?.toInt(),
  mpgCombined: (json['mpgCombined'] as num?)?.toInt(),
);

Map<String, dynamic> _$VehicleSpecToJson(VehicleSpec instance) =>
    <String, dynamic>{
      'uuid': instance.uuid,
      'make': instance.make,
      'model': instance.model,
      'year': instance.year,
      'trim': instance.trim,
      'body': instance.body,
      'driveType': instance.driveType,
      'fuelType': instance.fuelType,
      'engineCylinders': instance.engineCylinders,
      'engineCc': instance.engineCc,
      'numDoors': instance.numDoors,
      'transmission': instance.transmission,
      'epaClass': instance.epaClass,
      'mpgCity': instance.mpgCity,
      'mpgHighway': instance.mpgHighway,
      'mpgCombined': instance.mpgCombined,
    };

EngineConfig _$EngineConfigFromJson(Map<String, dynamic> json) => EngineConfig(
  name: json['name'] as String,
  displacementCc: (json['displacementCc'] as num).toInt(),
  cylinders: (json['cylinders'] as num).toInt(),
  powerHp: (json['powerHp'] as num).toInt(),
  fuelType: json['fuelType'] as String,
);

Map<String, dynamic> _$EngineConfigToJson(EngineConfig instance) =>
    <String, dynamic>{
      'name': instance.name,
      'displacementCc': instance.displacementCc,
      'cylinders': instance.cylinders,
      'powerHp': instance.powerHp,
      'fuelType': instance.fuelType,
    };

TransmissionConfig _$TransmissionConfigFromJson(Map<String, dynamic> json) =>
    TransmissionConfig(
      name: json['name'] as String,
      type: json['type'] as String,
      gears: (json['gears'] as num).toInt(),
    );

Map<String, dynamic> _$TransmissionConfigToJson(TransmissionConfig instance) =>
    <String, dynamic>{
      'name': instance.name,
      'type': instance.type,
      'gears': instance.gears,
    };

VehicleConfiguration _$VehicleConfigurationFromJson(
  Map<String, dynamic> json,
) => VehicleConfiguration(
  id: json['id'] as String,
  make: json['make'] as String,
  model: json['model'] as String,
  yearFrom: (json['yearFrom'] as num).toInt(),
  yearTo: (json['yearTo'] as num).toInt(),
  engines: (json['engines'] as List<dynamic>)
      .map((e) => EngineConfig.fromJson(e as Map<String, dynamic>))
      .toList(),
  transmissions: (json['transmissions'] as List<dynamic>)
      .map((e) => TransmissionConfig.fromJson(e as Map<String, dynamic>))
      .toList(),
  market: json['market'] as String,
);

Map<String, dynamic> _$VehicleConfigurationToJson(
  VehicleConfiguration instance,
) => <String, dynamic>{
  'id': instance.id,
  'make': instance.make,
  'model': instance.model,
  'yearFrom': instance.yearFrom,
  'yearTo': instance.yearTo,
  'engines': instance.engines,
  'transmissions': instance.transmissions,
  'market': instance.market,
};
