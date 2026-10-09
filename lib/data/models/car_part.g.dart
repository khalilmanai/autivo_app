// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'car_part.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CarPart _$CarPartFromJson(Map<String, dynamic> json) => CarPart(
  id: json['id'] as String,
  carId: json['carId'] as String,
  ownerId: json['ownerId'] as String,
  partId: json['partId'] as String,
  status: json['status'] as String,
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
  replacedAt: json['replacedAt'] == null
      ? null
      : DateTime.parse(json['replacedAt'] as String),
  mileageAtReplacement: (json['mileageAtReplacement'] as num?)?.toInt(),
  notes: json['notes'] as String?,
);

Map<String, dynamic> _$CarPartToJson(CarPart instance) => <String, dynamic>{
  'id': instance.id,
  'carId': instance.carId,
  'ownerId': instance.ownerId,
  'partId': instance.partId,
  'status': instance.status,
  'replacedAt': instance.replacedAt?.toIso8601String(),
  'mileageAtReplacement': instance.mileageAtReplacement,
  'notes': instance.notes,
  'createdAt': instance.createdAt.toIso8601String(),
  'updatedAt': instance.updatedAt.toIso8601String(),
};

UpsertCarPartRequest _$UpsertCarPartRequestFromJson(
  Map<String, dynamic> json,
) => UpsertCarPartRequest(
  status: json['status'] as String,
  replacedAt: json['replacedAt'] == null
      ? null
      : DateTime.parse(json['replacedAt'] as String),
  mileageAtReplacement: (json['mileageAtReplacement'] as num?)?.toInt(),
  notes: json['notes'] as String?,
);

Map<String, dynamic> _$UpsertCarPartRequestToJson(
  UpsertCarPartRequest instance,
) => <String, dynamic>{
  'status': instance.status,
  'replacedAt': instance.replacedAt?.toIso8601String(),
  'mileageAtReplacement': instance.mileageAtReplacement,
  'notes': instance.notes,
};
