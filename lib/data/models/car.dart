import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'car.g.dart';

@JsonSerializable()
class IdentificationData extends Equatable {
  final String method;
  final String? provider;
  final String confidence;
  final bool confirmedByUser;
  final DateTime? confirmedAt;

  const IdentificationData({
    required this.method,
    required this.confidence,
    required this.confirmedByUser,
    this.provider,
    this.confirmedAt,
  });

  factory IdentificationData.fromJson(Map<String, dynamic> json) =>
      _$IdentificationDataFromJson(json);
  Map<String, dynamic> toJson() => _$IdentificationDataToJson(this);

  @override
  List<Object?> get props => [
    method,
    provider,
    confidence,
    confirmedByUser,
    confirmedAt,
  ];
}

@JsonSerializable()
class Car extends Equatable {
  final String id;
  final String ownerId;
  final String make;
  final String model;
  final int year;
  final String fuelType;
  final String transmission;
  final int mileage;
  final String color;
  final String colorName;
  final String vin;
  final String licensePlate;
  final String engine;
  final String status;
  final String? image;
  final int serviceInterval;
  final IdentificationData identification;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Car({
    required this.id,
    required this.ownerId,
    required this.make,
    required this.model,
    required this.year,
    required this.fuelType,
    required this.transmission,
    required this.mileage,
    required this.color,
    required this.colorName,
    required this.vin,
    required this.licensePlate,
    required this.engine,
    required this.status,
    required this.serviceInterval,
    required this.identification,
    required this.createdAt,
    required this.updatedAt,
    this.image,
  });

  factory Car.fromJson(Map<String, dynamic> json) => _$CarFromJson(json);
  Map<String, dynamic> toJson() => _$CarToJson(this);

  String get statusLabel {
    switch (status) {
      case 'active':
        return 'Everything looks good';
      case 'maintenance':
        return 'Maintenance due soon';
      case 'inactive':
        return 'Vehicle inactive';
      default:
        return status;
    }
  }

  String get fuelLabel {
    switch (fuelType) {
      case 'gasoline':
        return 'Petrol';
      case 'diesel':
        return 'Diesel';
      case 'electric':
        return 'Electric';
      case 'hybrid':
        return 'Hybrid';
      case 'flex_fuel':
        return 'Flex Fuel';
      default:
        return fuelType;
    }
  }

  double get serviceProgress {
    if (serviceInterval <= 0) return 0;
    return (mileage % serviceInterval) / serviceInterval;
  }

  bool get isMaintenanceDue =>
      mileage % serviceInterval >= serviceInterval * 0.8;

  @override
  List<Object?> get props => [
    id,
    ownerId,
    make,
    model,
    year,
    fuelType,
    transmission,
    mileage,
    color,
    colorName,
    vin,
    licensePlate,
    engine,
    status,
    image,
    serviceInterval,
    identification,
    createdAt,
    updatedAt,
  ];
}

@JsonSerializable()
class CreateCarRequest extends Equatable {
  final String make;
  final String model;
  final int year;
  final String fuelType;
  final String transmission;
  final int mileage;
  final String color;
  final String colorName;
  final String vin;
  final String licensePlate;
  final String engine;
  final String? status;
  final String? image;
  final int? serviceInterval;
  final IdentificationData? identification;

  const CreateCarRequest({
    required this.make,
    required this.model,
    required this.year,
    required this.fuelType,
    required this.transmission,
    required this.mileage,
    required this.color,
    required this.colorName,
    required this.vin,
    required this.licensePlate,
    required this.engine,
    this.status,
    this.image,
    this.serviceInterval,
    this.identification,
  });

  factory CreateCarRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateCarRequestFromJson(json);
  Map<String, dynamic> toJson() => _$CreateCarRequestToJson(this);

  @override
  List<Object?> get props => [
    make,
    model,
    year,
    fuelType,
    transmission,
    mileage,
    color,
    colorName,
    vin,
    licensePlate,
    engine,
    status,
    image,
    serviceInterval,
    identification,
  ];
}

@JsonSerializable()
class UpdateCarRequest extends Equatable {
  final String? make;
  final String? model;
  final int? year;
  final String? fuelType;
  final String? transmission;
  final int? mileage;
  final String? color;
  final String? colorName;
  final String? vin;
  final String? licensePlate;
  final String? engine;
  final String? status;
  final String? image;
  final int? serviceInterval;
  final IdentificationData? identification;

  const UpdateCarRequest({
    this.make,
    this.model,
    this.year,
    this.fuelType,
    this.transmission,
    this.mileage,
    this.color,
    this.colorName,
    this.vin,
    this.licensePlate,
    this.engine,
    this.status,
    this.image,
    this.serviceInterval,
    this.identification,
  });

  factory UpdateCarRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateCarRequestFromJson(json);
  Map<String, dynamic> toJson() => _$UpdateCarRequestToJson(this);

  @override
  List<Object?> get props => [
    make,
    model,
    year,
    fuelType,
    transmission,
    mileage,
    color,
    colorName,
    vin,
    licensePlate,
    engine,
    status,
    image,
    serviceInterval,
    identification,
  ];
}
