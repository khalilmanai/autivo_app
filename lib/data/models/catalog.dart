import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'catalog.g.dart';

@JsonSerializable()
class VehicleSpec extends Equatable {
  final String uuid;
  final String make;
  final String model;
  final int year;
  final String trim;
  final String body;
  final String driveType;
  final String fuelType;
  final int? engineCylinders;
  final int? engineCc;
  final int? numDoors;
  final String transmission;
  final String epaClass;
  final int? mpgCity;
  final int? mpgHighway;
  final int? mpgCombined;

  const VehicleSpec({
    required this.uuid,
    required this.make,
    required this.model,
    required this.year,
    required this.trim,
    required this.body,
    required this.driveType,
    required this.fuelType,
    required this.transmission,
    required this.epaClass,
    this.engineCylinders,
    this.engineCc,
    this.numDoors,
    this.mpgCity,
    this.mpgHighway,
    this.mpgCombined,
  });

  factory VehicleSpec.fromJson(Map<String, dynamic> json) =>
      _$VehicleSpecFromJson(json);
  Map<String, dynamic> toJson() => _$VehicleSpecToJson(this);

  @override
  List<Object?> get props => [
    uuid,
    make,
    model,
    year,
    trim,
    body,
    driveType,
    fuelType,
    engineCylinders,
    engineCc,
    numDoors,
    transmission,
    epaClass,
    mpgCity,
    mpgHighway,
    mpgCombined,
  ];
}

@JsonSerializable()
class EngineConfig extends Equatable {
  final String name;
  final int displacementCc;
  final int cylinders;
  final int powerHp;
  final String fuelType;

  const EngineConfig({
    required this.name,
    required this.displacementCc,
    required this.cylinders,
    required this.powerHp,
    required this.fuelType,
  });

  factory EngineConfig.fromJson(Map<String, dynamic> json) =>
      _$EngineConfigFromJson(json);
  Map<String, dynamic> toJson() => _$EngineConfigToJson(this);

  @override
  List<Object?> get props => [
    name,
    displacementCc,
    cylinders,
    powerHp,
    fuelType,
  ];
}

@JsonSerializable()
class TransmissionConfig extends Equatable {
  final String name;
  final String type;
  final int gears;

  const TransmissionConfig({
    required this.name,
    required this.type,
    required this.gears,
  });

  factory TransmissionConfig.fromJson(Map<String, dynamic> json) =>
      _$TransmissionConfigFromJson(json);
  Map<String, dynamic> toJson() => _$TransmissionConfigToJson(this);

  @override
  List<Object?> get props => [name, type, gears];
}

@JsonSerializable()
class VehicleConfiguration extends Equatable {
  final String id;
  final String make;
  final String model;
  final int yearFrom;
  final int yearTo;
  final List<EngineConfig> engines;
  final List<TransmissionConfig> transmissions;
  final String market;

  const VehicleConfiguration({
    required this.id,
    required this.make,
    required this.model,
    required this.yearFrom,
    required this.yearTo,
    required this.engines,
    required this.transmissions,
    required this.market,
  });

  factory VehicleConfiguration.fromJson(Map<String, dynamic> json) =>
      _$VehicleConfigurationFromJson(json);
  Map<String, dynamic> toJson() => _$VehicleConfigurationToJson(this);

  @override
  List<Object?> get props => [
    id,
    make,
    model,
    yearFrom,
    yearTo,
    engines,
    transmissions,
    market,
  ];
}
