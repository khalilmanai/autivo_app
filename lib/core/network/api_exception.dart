import 'package:dio/dio.dart';
import '../constants/app_constants.dart';

class ApiException implements Exception {
  final String code;
  final String message;
  final List<FieldIssue>? details;
  final int? statusCode;

  ApiException({
    required this.code,
    required this.message,
    this.details,
    this.statusCode,
  });

  factory ApiException.fromResponse(Response response) {
    final data = response.data;
    if (data is Map && data['success'] == false && data['error'] is Map) {
      final error = data['error'] as Map;
      final code = error['code'] as String? ?? ErrorCodes.unknownError;
      final message = error['message'] as String? ?? 'An error occurred';
      final detailsRaw = error['details'];
      List<FieldIssue>? details;
      if (detailsRaw is List) {
        details = [];
        for (final d in detailsRaw) {
          if (d is Map) {
            details.add(FieldIssue.fromJson(d));
          }
        }
      }
      return ApiException(
        code: code,
        message: message,
        details: details?.isNotEmpty == true ? details : null,
        statusCode: response.statusCode,
      );
    }

    return _fromStatusCode(response.statusCode);
  }

  factory ApiException.fromDioError(DioException e) {
    if (e.response != null) {
      return ApiException.fromResponse(e.response!);
    }
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return ApiException(
          code: ErrorCodes.timeout,
          message: 'Request timed out. Please try again.',
        );
      case DioExceptionType.connectionError:
        return ApiException(
          code: ErrorCodes.networkError,
          message: 'No internet connection. Please check your network.',
        );
      default:
        return ApiException(
          code: ErrorCodes.unknownError,
          message: 'An unexpected error occurred',
        );
    }
  }

  static ApiException _fromStatusCode(int? statusCode) {
    switch (statusCode) {
      case 401:
        return ApiException(
          code: ErrorCodes.authenticationRequired,
          message: 'Authentication required',
          statusCode: statusCode,
        );
      case 403:
        return ApiException(
          code: ErrorCodes.forbidden,
          message: 'Access denied',
          statusCode: statusCode,
        );
      case 404:
        return ApiException(
          code: ErrorCodes.notFound,
          message: 'Resource not found',
          statusCode: statusCode,
        );
      case 409:
        return ApiException(
          code: ErrorCodes.conflict,
          message: 'Conflict occurred',
          statusCode: statusCode,
        );
      case 429:
        return ApiException(
          code: ErrorCodes.rateLimitExceeded,
          message: 'Too many requests',
          statusCode: statusCode,
        );
      case 500:
        return ApiException(
          code: ErrorCodes.internalServerError,
          message: 'Internal server error',
          statusCode: statusCode,
        );
      case 502:
      case 503:
      case 504:
        return ApiException(
          code: ErrorCodes.internalServerError,
          message: 'Server is temporarily unavailable',
          statusCode: statusCode,
        );
      default:
        return ApiException(
          code: ErrorCodes.unknownError,
          message: 'An unexpected error occurred',
          statusCode: statusCode,
        );
    }
  }

  @override
  String toString() => 'ApiException($code): $message';
}

class FieldIssue {
  final String field;
  final String message;

  FieldIssue({required this.field, required this.message});

  factory FieldIssue.fromJson(Map json) => FieldIssue(
    field: json['field'] as String? ?? '',
    message: json['message'] as String? ?? '',
  );
}

extension DioExceptionExtension on DioException {
  ApiException toApiException() => ApiException.fromDioError(this);
}
