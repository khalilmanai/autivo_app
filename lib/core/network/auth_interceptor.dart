import 'package:dio/dio.dart';
import '../constants/endpoints/auth_endpoints.dart';
import '../storage/secure_storage_service.dart';

typedef RefreshTokenHandler = Future<void> Function(String refreshToken);
typedef OnAuthCleared = Future<void> Function();

class AuthInterceptor extends Interceptor {
  final SecureStorageService _storage;
  final RefreshTokenHandler _refreshHandler;
  final OnAuthCleared? _onAuthCleared;
  Dio? _dio;
  bool _isRefreshing = false;

  AuthInterceptor(
    this._storage,
    this._refreshHandler, {
    OnAuthCleared? onAuthCleared,
  }) : _onAuthCleared = onAuthCleared;

  void setDio(Dio dio) => _dio = dio;

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final accessToken = await _storage.getAccessToken();
    if (accessToken != null && accessToken.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $accessToken';
    }
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401 && !_isRefreshing) {
      final requestPath = err.requestOptions.path;
      if (requestPath.contains(AuthEndpoints.refresh) ||
          requestPath.contains(AuthEndpoints.login) ||
          requestPath.contains(AuthEndpoints.register)) {
        handler.next(err);
        return;
      }

      _isRefreshing = true;
      try {
        final refreshToken = await _storage.getRefreshToken();
        if (refreshToken == null) throw Exception('No refresh token');

        await _refreshHandler(refreshToken);
        final newToken = await _storage.getAccessToken();
        if (newToken != null) {
          err.requestOptions.headers['Authorization'] = 'Bearer $newToken';
          final dio = _dio ?? Dio();
          final response = await dio.fetch(err.requestOptions);
          handler.resolve(response);
          return;
        }
      } catch (e) {
        await _clearAuth();
      } finally {
        _isRefreshing = false;
      }
    }
    handler.next(err);
  }

  Future<void> _clearAuth() async {
    await _storage.clearAuth();
    await _onAuthCleared?.call();
  }
}
