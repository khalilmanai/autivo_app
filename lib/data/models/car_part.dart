import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'car_part.g.dart';

@JsonSerializable()
class CarPart extends Equatable {
  final String id;
  final String carId;
  final String ownerId;
  final String partId;
  final String status;
  final DateTime? replacedAt;
  final int? mileageAtReplacement;
  final String? notes;
  final DateTime createdAt;
  final DateTime updatedAt;

  const CarPart({
    required this.id,
    required this.carId,
    required this.ownerId,
    required this.partId,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    this.replacedAt,
    this.mileageAtReplacement,
    this.notes,
  });

  factory CarPart.fromJson(Map<String, dynamic> json) =>
      _$CarPartFromJson(json);
  Map<String, dynamic> toJson() => _$CarPartToJson(this);

  @override
  List<Object?> get props => [
    id,
    carId,
    ownerId,
    partId,
    status,
    replacedAt,
    mileageAtReplacement,
    notes,
    createdAt,
    updatedAt,
  ];
}

@JsonSerializable()
class UpsertCarPartRequest extends Equatable {
  final String status;
  final DateTime? replacedAt;
  final int? mileageAtReplacement;
  final String? notes;

  const UpsertCarPartRequest({
    required this.status,
    this.replacedAt,
    this.mileageAtReplacement,
    this.notes,
  });

  factory UpsertCarPartRequest.fromJson(Map<String, dynamic> json) =>
      _$UpsertCarPartRequestFromJson(json);
  Map<String, dynamic> toJson() => _$UpsertCarPartRequestToJson(this);

  @override
  List<Object?> get props => [status, replacedAt, mileageAtReplacement, notes];
}
