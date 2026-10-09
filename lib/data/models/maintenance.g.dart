// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'maintenance.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Maintenance _$MaintenanceFromJson(Map<String, dynamic> json) => Maintenance(
  id: json['id'] as String,
  carId: json['carId'] as String,
  ownerId: json['ownerId'] as String,
  type: json['type'] as String,
  title: json['title'] as String,
  cost: (json['cost'] as num).toDouble(),
  date: DateTime.parse(json['date'] as String),
  parts: (json['parts'] as List<dynamic>).map((e) => e as String).toList(),
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
  mileage: (json['mileage'] as num?)?.toInt(),
  garage: json['garage'] as String?,
  category: json['category'] as String?,
  notes: json['notes'] as String?,
  nextServiceMileage: (json['nextServiceMileage'] as num?)?.toInt(),
);

Map<String, dynamic> _$MaintenanceToJson(Maintenance instance) =>
    <String, dynamic>{
      'id': instance.id,
      'carId': instance.carId,
      'ownerId': instance.ownerId,
      'type': instance.type,
      'title': instance.title,
      'cost': instance.cost,
      'mileage': instance.mileage,
      'date': instance.date.toIso8601String(),
      'garage': instance.garage,
      'category': instance.category,
      'notes': instance.notes,
      'parts': instance.parts,
      'nextServiceMileage': instance.nextServiceMileage,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };

CreateMaintenanceRequest _$CreateMaintenanceRequestFromJson(
  Map<String, dynamic> json,
) => CreateMaintenanceRequest(
  type: json['type'] as String,
  title: json['title'] as String,
  cost: (json['cost'] as num).toDouble(),
  mileage: (json['mileage'] as num?)?.toInt(),
  date: json['date'] == null ? null : DateTime.parse(json['date'] as String),
  garage: json['garage'] as String?,
  category: json['category'] as String?,
  notes: json['notes'] as String?,
  parts: (json['parts'] as List<dynamic>?)?.map((e) => e as String).toList(),
  nextServiceMileage: (json['nextServiceMileage'] as num?)?.toInt(),
);

Map<String, dynamic> _$CreateMaintenanceRequestToJson(
  CreateMaintenanceRequest instance,
) => <String, dynamic>{
  'type': instance.type,
  'title': instance.title,
  'cost': instance.cost,
  'mileage': instance.mileage,
  'date': instance.date?.toIso8601String(),
  'garage': instance.garage,
  'category': instance.category,
  'notes': instance.notes,
  'parts': instance.parts,
  'nextServiceMileage': instance.nextServiceMileage,
};

UpdateMaintenanceRequest _$UpdateMaintenanceRequestFromJson(
  Map<String, dynamic> json,
) => UpdateMaintenanceRequest(
  type: json['type'] as String?,
  title: json['title'] as String?,
  cost: (json['cost'] as num?)?.toDouble(),
  mileage: (json['mileage'] as num?)?.toInt(),
  date: json['date'] == null ? null : DateTime.parse(json['date'] as String),
  garage: json['garage'] as String?,
  category: json['category'] as String?,
  notes: json['notes'] as String?,
  parts: (json['parts'] as List<dynamic>?)?.map((e) => e as String).toList(),
  nextServiceMileage: (json['nextServiceMileage'] as num?)?.toInt(),
);

Map<String, dynamic> _$UpdateMaintenanceRequestToJson(
  UpdateMaintenanceRequest instance,
) => <String, dynamic>{
  'type': instance.type,
  'title': instance.title,
  'cost': instance.cost,
  'mileage': instance.mileage,
  'date': instance.date?.toIso8601String(),
  'garage': instance.garage,
  'category': instance.category,
  'notes': instance.notes,
  'parts': instance.parts,
  'nextServiceMileage': instance.nextServiceMileage,
};
