// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'car.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IdentificationData _$IdentificationDataFromJson(Map<String, dynamic> json) =>
    IdentificationData(
      method: json['method'] as String,
      confidence: json['confidence'] as String,
      confirmedByUser: json['confirmedByUser'] as bool,
      provider: json['provider'] as String?,
      confirmedAt: json['confirmedAt'] == null
          ? null
          : DateTime.parse(json['confirmedAt'] as String),
    );

Map<String, dynamic> _$IdentificationDataToJson(IdentificationData instance) =>
    <String, dynamic>{
      'method': instance.method,
      'provider': instance.provider,
      'confidence': instance.confidence,
      'confirmedByUser': instance.confirmedByUser,
      'confirmedAt': instance.confirmedAt?.toIso8601String(),
    };

Car _$CarFromJson(Map<String, dynamic> json) => Car(
  id: json['id'] as String,
  ownerId: json['ownerId'] as String,
  make: json['make'] as String,
  model: json['model'] as String,
  year: (json['year'] as num).toInt(),
  fuelType: json['fuelType'] as String,
  transmission: json['transmission'] as String,
  mileage: (json['mileage'] as num).toInt(),
  color: json['color'] as String,
  colorName: json['colorName'] as String,
  vin: json['vin'] as String,
  licensePlate: json['licensePlate'] as String,
  engine: json['engine'] as String,
  status: json['status'] as String,
  serviceInterval: (json['serviceInterval'] as num).toInt(),
  identification: IdentificationData.fromJson(
    json['identification'] as Map<String, dynamic>,
  ),
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
  image: json['image'] as String?,
);

Map<String, dynamic> _$CarToJson(Car instance) => <String, dynamic>{
  'id': instance.id,
  'ownerId': instance.ownerId,
  'make': instance.make,
  'model': instance.model,
  'year': instance.year,
  'fuelType': instance.fuelType,
  'transmission': instance.transmission,
  'mileage': instance.mileage,
  'color': instance.color,
  'colorName': instance.colorName,
  'vin': instance.vin,
  'licensePlate': instance.licensePlate,
  'engine': instance.engine,
  'status': instance.status,
  'image': instance.image,
  'serviceInterval': instance.serviceInterval,
  'identification': instance.identification,
  'createdAt': instance.createdAt.toIso8601String(),
  'updatedAt': instance.updatedAt.toIso8601String(),
};

CreateCarRequest _$CreateCarRequestFromJson(Map<String, dynamic> json) =>
    CreateCarRequest(
      make: json['make'] as String,
      model: json['model'] as String,
      year: (json['year'] as num).toInt(),
      fuelType: json['fuelType'] as String,
      transmission: json['transmission'] as String,
      mileage: (json['mileage'] as num).toInt(),
      color: json['color'] as String,
      colorName: json['colorName'] as String,
      vin: json['vin'] as String,
      licensePlate: json['licensePlate'] as String,
      engine: json['engine'] as String,
      status: json['status'] as String?,
      image: json['image'] as String?,
      serviceInterval: (json['serviceInterval'] as num?)?.toInt(),
      identification: json['identification'] == null
          ? null
          : IdentificationData.fromJson(
              json['identification'] as Map<String, dynamic>,
            ),
    );

Map<String, dynamic> _$CreateCarRequestToJson(CreateCarRequest instance) =>
    <String, dynamic>{
      'make': instance.make,
      'model': instance.model,
      'year': instance.year,
      'fuelType': instance.fuelType,
      'transmission': instance.transmission,
      'mileage': instance.mileage,
      'color': instance.color,
      'colorName': instance.colorName,
      'vin': instance.vin,
      'licensePlate': instance.licensePlate,
      'engine': instance.engine,
      'status': instance.status,
      'image': instance.image,
      'serviceInterval': instance.serviceInterval,
      'identification': instance.identification,
    };

UpdateCarRequest _$UpdateCarRequestFromJson(Map<String, dynamic> json) =>
    UpdateCarRequest(
      make: json['make'] as String?,
      model: json['model'] as String?,
      year: (json['year'] as num?)?.toInt(),
      fuelType: json['fuelType'] as String?,
      transmission: json['transmission'] as String?,
      mileage: (json['mileage'] as num?)?.toInt(),
      color: json['color'] as String?,
      colorName: json['colorName'] as String?,
      vin: json['vin'] as String?,
      licensePlate: json['licensePlate'] as String?,
      engine: json['engine'] as String?,
      status: json['status'] as String?,
      image: json['image'] as String?,
      serviceInterval: (json['serviceInterval'] as num?)?.toInt(),
      identification: json['identification'] == null
          ? null
          : IdentificationData.fromJson(
              json['identification'] as Map<String, dynamic>,
            ),
    );

Map<String, dynamic> _$UpdateCarRequestToJson(UpdateCarRequest instance) =>
    <String, dynamic>{
      'make': instance.make,
      'model': instance.model,
      'year': instance.year,
      'fuelType': instance.fuelType,
      'transmission': instance.transmission,
      'mileage': instance.mileage,
      'color': instance.color,
      'colorName': instance.colorName,
      'vin': instance.vin,
      'licensePlate': instance.licensePlate,
      'engine': instance.engine,
      'status': instance.status,
      'image': instance.image,
      'serviceInterval': instance.serviceInterval,
      'identification': instance.identification,
    };
