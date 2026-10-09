import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'maintenance.g.dart';

@JsonSerializable()
class Maintenance extends Equatable {
  final String id;
  final String carId;
  final String ownerId;
  final String type;
  final String title;
  final double cost;
  final int? mileage;
  final DateTime date;
  final String? garage;
  final String? category;
  final String? notes;
  final List<String> parts;
  final int? nextServiceMileage;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Maintenance({
    required this.id,
    required this.carId,
    required this.ownerId,
    required this.type,
    required this.title,
    required this.cost,
    required this.date,
    required this.parts,
    required this.createdAt,
    required this.updatedAt,
    this.mileage,
    this.garage,
    this.category,
    this.notes,
    this.nextServiceMileage,
  });

  factory Maintenance.fromJson(Map<String, dynamic> json) =>
      _$MaintenanceFromJson(json);
  Map<String, dynamic> toJson() => _$MaintenanceToJson(this);

  @override
  List<Object?> get props => [
    id,
    carId,
    ownerId,
    type,
    title,
    cost,
    mileage,
    date,
    garage,
    category,
    notes,
    parts,
    nextServiceMileage,
    createdAt,
    updatedAt,
  ];
}

@JsonSerializable()
class CreateMaintenanceRequest extends Equatable {
  final String type;
  final String title;
  final double cost;
  final int? mileage;
  final DateTime? date;
  final String? garage;
  final String? category;
  final String? notes;
  final List<String>? parts;
  final int? nextServiceMileage;

  const CreateMaintenanceRequest({
    required this.type,
    required this.title,
    required this.cost,
    this.mileage,
    this.date,
    this.garage,
    this.category,
    this.notes,
    this.parts,
    this.nextServiceMileage,
  });

  factory CreateMaintenanceRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateMaintenanceRequestFromJson(json);
  Map<String, dynamic> toJson() => _$CreateMaintenanceRequestToJson(this);

  @override
  List<Object?> get props => [
    type,
    title,
    cost,
    mileage,
    date,
    garage,
    category,
    notes,
    parts,
    nextServiceMileage,
  ];
}

@JsonSerializable()
class UpdateMaintenanceRequest extends Equatable {
  final String? type;
  final String? title;
  final double? cost;
  final int? mileage;
  final DateTime? date;
  final String? garage;
  final String? category;
  final String? notes;
  final List<String>? parts;
  final int? nextServiceMileage;

  const UpdateMaintenanceRequest({
    this.type,
    this.title,
    this.cost,
    this.mileage,
    this.date,
    this.garage,
    this.category,
    this.notes,
    this.parts,
    this.nextServiceMileage,
  });

  factory UpdateMaintenanceRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateMaintenanceRequestFromJson(json);
  Map<String, dynamic> toJson() => _$UpdateMaintenanceRequestToJson(this);

  @override
  List<Object?> get props => [
    type,
    title,
    cost,
    mileage,
    date,
    garage,
    category,
    notes,
    parts,
    nextServiceMileage,
  ];
}

const List<String> maintenanceTypesValues = [
  'maintenance',
  'repair',
  'paint',
  'accident',
  'fuel',
  'document',
  'inspection',
  'modification',
  'tires',
  'battery',
  'electrical',
];

const Map<String, String> maintenanceTypesLabels = {
  'maintenance': 'Maintenance',
  'repair': 'Repair',
  'paint': 'Paint & Body',
  'accident': 'Accident',
  'fuel': 'Fuel',
  'document': 'Document',
  'inspection': 'Inspection',
  'modification': 'Modification',
  'tires': 'Tires',
  'battery': 'Battery',
  'electrical': 'Electrical',
};

const List<String> maintenanceTypes = maintenanceTypesValues;
