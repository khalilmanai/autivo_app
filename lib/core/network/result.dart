import 'api_exception.dart';

class Result<T> {
  final T? data;
  final ApiException? error;

  const Result._({this.data, this.error});

  factory Result.success(T data) => Result._(data: data);
  factory Result.failure(ApiException error) => Result._(error: error);

  bool get isSuccess => error == null;
  bool get isFailure => error != null;

  T getOrThrow() {
    if (isSuccess) return data!;
    throw error!;
  }
}
