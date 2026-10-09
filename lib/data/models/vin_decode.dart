import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'vin_decode.g.dart';

@JsonSerializable()
class VinSuggestion extends Equatable {
  final String name;
  final String? detail;

  const VinSuggestion({required this.name, this.detail});

  factory VinSuggestion.fromJson(Map<String, dynamic> json) =>
      _$VinSuggestionFromJson(json);
  Map<String, dynamic> toJson() => _$VinSuggestionToJson(this);

  @override
  List<Object?> get props => [name, detail];
}

@JsonSerializable()
class VinDecodeResult extends Equatable {
  final String vin;
  final String make;
  final String model;
  final int year;
  final String fuelType;
  final String fuelLabel;
  final String transmission;
  final String bodyClass;
  final String engineCylinders;
  final String engineHP;
  final String plantCountry;
  final String trim;
  final String drivetrain;
  final String doors;
  final String engineConfiguration;
  final String engineDisplacementL;
  final String transmissionSpeeds;
  final String valveTrainDesign;
  final String plantCity;
  final String plantState;
  final String manufacturer;
  final String vehicleType;

  /// Only populated for electric and plug-in hybrid vehicles, when NHTSA has
  /// the data. `null` otherwise, so the UI can omit it instead of showing a
  /// placeholder zero.
  final String? batteryKWh;

  /// vPIC electrification level, e.g. `BEV`, `PHEV`, `HEV`.
  final String? electrificationLevel;

  final num engineKw;
  final num displacementCc;
  final List<String> missingFields;
  final Map<String, List<VinSuggestion>> suggestions;
  final String source;
  final String confidence;

  const VinDecodeResult({
    required this.vin,
    required this.make,
    required this.model,
    required this.year,
    required this.fuelType,
    required this.fuelLabel,
    required this.transmission,
    required this.bodyClass,
    required this.engineCylinders,
    required this.engineHP,
    required this.plantCountry,
    required this.trim,
    required this.drivetrain,
    required this.doors,
    required this.engineConfiguration,
    required this.engineDisplacementL,
    required this.transmissionSpeeds,
    required this.valveTrainDesign,
    required this.plantCity,
    required this.plantState,
    required this.manufacturer,
    required this.vehicleType,
    required this.missingFields,
    required this.suggestions,
    required this.source,
    required this.confidence,
    this.batteryKWh,
    this.electrificationLevel,
    this.engineKw = 0,
    this.displacementCc = 0,
  });

  factory VinDecodeResult.fromJson(Map<String, dynamic> json) =>
      _$VinDecodeResultFromJson(json);
  Map<String, dynamic> toJson() => _$VinDecodeResultToJson(this);

  @override
  List<Object?> get props => [
    vin,
    make,
    model,
    year,
    fuelType,
    fuelLabel,
    transmission,
    bodyClass,
    engineCylinders,
    engineHP,
    plantCountry,
    trim,
    drivetrain,
    doors,
    engineConfiguration,
    engineDisplacementL,
    transmissionSpeeds,
    valveTrainDesign,
    plantCity,
    plantState,
    manufacturer,
    vehicleType,
    batteryKWh,
    electrificationLevel,
    engineKw,
    displacementCc,
    missingFields,
    suggestions,
    source,
    confidence,
  ];
}

@JsonSerializable()
class DecodeVinRequest extends Equatable {
  final String vin;

  const DecodeVinRequest({required this.vin});

  factory DecodeVinRequest.fromJson(Map<String, dynamic> json) =>
      _$DecodeVinRequestFromJson(json);
  Map<String, dynamic> toJson() => _$DecodeVinRequestToJson(this);

  @override
  List<Object?> get props => [vin];
}
