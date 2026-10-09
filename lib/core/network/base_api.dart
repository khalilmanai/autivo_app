import 'package:dio/dio.dart';

import '../constants/app_constants.dart';
import 'api_exception.dart';
import 'result.dart';

typedef FromJson<T> = T Function(dynamic json);

abstract class BaseApi {
  final Dio dio;

  BaseApi(this.dio);

  dynamic _dataOf(dynamic responseData) {
    if (responseData is Map && responseData.containsKey('data')) {
      return responseData['data'];
    }
    return responseData;
  }

  dynamic _payloadOf(dynamic data, String? dataKey) {
    if (dataKey != null && data is Map) {
      return data[dataKey];
    }
    return data;
  }

  Result<T> _parse<T>(
    dynamic responseData,
    FromJson<T> fromJson, {
    String? dataKey,
  }) {
    final raw = _dataOf(responseData);
    return Result.success(fromJson(_payloadOf(raw, dataKey)));
  }

  Result<T> _malformed<T>() => Result.failure(
    ApiException(
      code: ErrorCodes.malformedJson,
      message: 'Unable to parse server response',
    ),
  );

  Future<Result<T>> apiGet<T>(
    String path, {
    required FromJson<T> fromJson,
    Map<String, dynamic>? queryParameters,
    bool allowNull = false,
    String? dataKey,
  }) async {
    try {
      final response = await dio.get(path, queryParameters: queryParameters);
      if (allowNull && _payloadOf(_dataOf(response.data), dataKey) == null) {
        return Result.success(null as T);
      }
      return _parse(response.data, fromJson, dataKey: dataKey);
    } on DioException catch (e) {
      if (allowNull && e.response?.statusCode == 404) {
        return Result.success(null as T);
      }
      return Result.failure(e.toApiException());
    } catch (e) {
      return _malformed();
    }
  }

  Future<Result<T>> apiPost<T>(
    String path, {
    required FromJson<T> fromJson,
    dynamic data,
    Map<String, dynamic>? queryParameters,
    String? dataKey,
  }) async {
    try {
      final response = await dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
      );
      return _parse(response.data, fromJson, dataKey: dataKey);
    } on DioException catch (e) {
      return Result.failure(e.toApiException());
    } catch (e) {
      return _malformed();
    }
  }

  Future<Result<T>> apiPatch<T>(
    String path, {
    required FromJson<T> fromJson,
    dynamic data,
    Map<String, dynamic>? queryParameters,
    String? dataKey,
  }) async {
    try {
      final response = await dio.patch(
        path,
        data: data,
        queryParameters: queryParameters,
      );
      return _parse(response.data, fromJson, dataKey: dataKey);
    } on DioException catch (e) {
      return Result.failure(e.toApiException());
    } catch (e) {
      return _malformed();
    }
  }

  Future<Result<T>> apiPut<T>(
    String path, {
    required FromJson<T> fromJson,
    dynamic data,
    Map<String, dynamic>? queryParameters,
    String? dataKey,
  }) async {
    try {
      final response = await dio.put(
        path,
        data: data,
        queryParameters: queryParameters,
      );
      return _parse(response.data, fromJson, dataKey: dataKey);
    } on DioException catch (e) {
      return Result.failure(e.toApiException());
    } catch (e) {
      return _malformed();
    }
  }

  Future<Result<void>> apiDelete(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      await dio.delete(path, queryParameters: queryParameters);
      return Result.success(null);
    } on DioException catch (e) {
      return Result.failure(e.toApiException());
    }
  }

  Future<Result<void>> apiPostVoid(String path, {dynamic data}) async {
    try {
      await dio.post(path, data: data);
      return Result.success(null);
    } on DioException catch (e) {
      return Result.failure(e.toApiException());
    }
  }
}
