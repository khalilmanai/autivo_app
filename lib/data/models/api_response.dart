import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'api_response.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class ApiResponse<T> extends Equatable {
  final bool success;
  final T? data;
  final ApiError? error;

  const ApiResponse({required this.success, this.data, this.error});

  factory ApiResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object?) fromJsonT,
  ) => _$ApiResponseFromJson(json, fromJsonT);
  Map<String, dynamic> toJson(Object Function(T) toJsonT) =>
      _$ApiResponseToJson(this, toJsonT);

  @override
  List<Object?> get props => [success, data, error];
}

@JsonSerializable()
class ApiError extends Equatable {
  final String code;
  final String message;
  final List<FieldIssue>? details;

  const ApiError({required this.code, required this.message, this.details});

  factory ApiError.fromJson(Map<String, dynamic> json) =>
      _$ApiErrorFromJson(json);
  Map<String, dynamic> toJson() => _$ApiErrorToJson(this);

  @override
  List<Object?> get props => [code, message, details];
}

@JsonSerializable()
class FieldIssue extends Equatable {
  final String field;
  final String message;

  const FieldIssue({required this.field, required this.message});

  factory FieldIssue.fromJson(Map<String, dynamic> json) =>
      _$FieldIssueFromJson(json);
  Map<String, dynamic> toJson() => _$FieldIssueToJson(this);

  @override
  List<Object?> get props => [field, message];
}

@JsonSerializable()
class HealthResponse extends Equatable {
  final String status;
  final String service;
  final DateTime timestamp;

  const HealthResponse({
    required this.status,
    required this.service,
    required this.timestamp,
  });

  factory HealthResponse.fromJson(Map<String, dynamic> json) =>
      _$HealthResponseFromJson(json);
  Map<String, dynamic> toJson() => _$HealthResponseToJson(this);

  @override
  List<Object?> get props => [status, service, timestamp];
}
