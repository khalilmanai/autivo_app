import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../core/constants/app_constants.dart';
import '../../core/network/api_exception.dart';
import '../../core/storage/prefs_service.dart';
import '../../core/storage/secure_storage_service.dart';
import '../../data/models/user.dart';
import '../../domain/usecases/usecases.dart';

class AuthViewModel extends ChangeNotifier {
  final RegisterUseCase _registerUseCase;
  final LoginUseCase _loginUseCase;
  final GetMeUseCase _getMeUseCase;
  final RefreshTokenUseCase _refreshTokenUseCase;
  final LogoutUseCase _logoutUseCase;
  final ForgotPasswordUseCase _forgotPasswordUseCase;
  final ResetPasswordUseCase _resetPasswordUseCase;
  final GoogleSignInUseCase _googleSignInUseCase;
  final SecureStorageService _storage;

  AuthViewModel(
    this._registerUseCase,
    this._loginUseCase,
    this._getMeUseCase,
    this._refreshTokenUseCase,
    this._logoutUseCase,
    this._forgotPasswordUseCase,
    this._resetPasswordUseCase,
    this._googleSignInUseCase,
    this._storage,
  );

  bool _isLoading = false;
  ApiException? _error;
  UserProfile? _user;
  AuthTokens? _tokens;
  bool _isAuthenticated = false;

  bool get isLoading => _isLoading;
  ApiException? get error => _error;
  UserProfile? get user => _user;
  AuthTokens? get tokens => _tokens;
  bool get isAuthenticated => _isAuthenticated;

  Map<String, String> get fieldErrors {
    if (_error?.details == null) return {};
    return {for (final d in _error!.details!) d.field: d.message};
  }

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void _setError(ApiException? error) {
    _error = error;
    notifyListeners();
  }

  Future<bool> register({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    UserPreferences? preferences,
  }) async {
    _setLoading(true);
    _setError(null);

    final result = await _registerUseCase(
      RegisterParams(
        firstName: firstName,
        lastName: lastName,
        email: email,
        password: password,
        preferences: preferences,
      ),
    );

    _setLoading(false);

    if (result.isSuccess) {
      _user = result.data!.user;
      _tokens = result.data!.tokens;
      _isAuthenticated = true;
      await _saveAuth();
      notifyListeners();
      return true;
    } else {
      _setError(result.error!);
      return false;
    }
  }

  Future<bool> login({required String email, required String password}) async {
    _setLoading(true);
    _setError(null);

    final result = await _loginUseCase(
      LoginParams(email: email, password: password),
    );

    _setLoading(false);

    if (result.isSuccess) {
      _user = result.data!.user;
      _tokens = result.data!.tokens;
      _isAuthenticated = true;
      await _saveAuth();
      notifyListeners();
      return true;
    } else {
      _setError(result.error!);
      return false;
    }
  }

  Future<bool> googleSignIn({UserPreferences? preferences}) async {
    _setLoading(true);
    _setError(null);

    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();
      final account = await googleSignIn.signIn();
      if (account == null) {
        _setLoading(false);
        return false;
      }
      final auth = await account.authentication;
      final idToken = auth.idToken;
      if (idToken == null) {
        _setLoading(false);
        _setError(
          ApiException(
            code: ErrorCodes.invalidGoogleToken,
            message: 'Failed to get Google ID token',
          ),
        );
        return false;
      }

      final result = await _googleSignInUseCase(
        GoogleSignInParams(idToken: idToken, preferences: preferences),
      );

      _setLoading(false);

      if (result.isSuccess) {
        _user = result.data!.user;
        _tokens = result.data!.tokens;
        _isAuthenticated = true;
        await _saveAuth();
        notifyListeners();
        return true;
      } else {
        _setError(result.error!);
        return false;
      }
    } catch (e) {
      _setLoading(false);
      _setError(
        ApiException(
          code: ErrorCodes.unknownError,
          message: 'Google sign-in failed: $e',
        ),
      );
      return false;
    }
  }

  Future<bool> loadUser() async {
    if (!_isAuthenticated) return false;

    _setLoading(true);

    // Check if token is expired
    if (await _storage.isAccessTokenExpired()) {
      final refreshed = await refreshToken();
      if (!refreshed) {
        _setLoading(false);
        return false;
      }
    }

    final result = await _getMeUseCase(null);
    _setLoading(false);

    if (result.isSuccess) {
      _user = result.data;
      notifyListeners();
      return true;
    } else {
      _setError(result.error);
      await _clearAuth();
      return false;
    }
  }

  Future<bool> refreshToken() async {
    final refreshToken = await _storage.getRefreshToken();
    if (refreshToken == null) return false;

    final result = await _refreshTokenUseCase(refreshToken);
    if (result.isSuccess) {
      _tokens = result.data;
      await _storage.saveTokens(
        accessToken: _tokens!.accessToken,
        refreshToken: _tokens!.refreshToken,
        accessTokenExpiresIn: _tokens!.accessTokenExpiresIn,
        refreshTokenExpiresAt: _tokens!.refreshTokenExpiresAt,
      );
      return true;
    }

    _setError(result.error);
    await _clearAuth();
    return false;
  }

  Future<bool> forgotPassword(String email) async {
    _setLoading(true);
    _setError(null);

    final result = await _forgotPasswordUseCase(email);

    _setLoading(false);

    if (result.isSuccess) {
      return true;
    } else {
      _setError(result.error!);
      return false;
    }
  }

  Future<bool> resetPassword({
    required String token,
    required String password,
  }) async {
    _setLoading(true);
    _setError(null);

    final result = await _resetPasswordUseCase(
      ResetPasswordParams(token: token, password: password),
    );

    _setLoading(false);

    if (result.isSuccess) {
      return true;
    } else {
      _setError(result.error!);
      return false;
    }
  }

  Future<void> logout() async {
    _setLoading(true);

    final refreshToken = await _storage.getRefreshToken();
    await _logoutUseCase(refreshToken);
    await _clearAuth();

    _setLoading(false);
  }

  Future<void> forceLogout() async {
    _error ??= ApiException(
      code: ErrorCodes.authenticationRequired,
      message: 'Authentication required',
      statusCode: 401,
    );
    await _clearAuth();
  }

  Future<void> _saveAuth() async {
    if (_tokens != null && _user != null) {
      await _storage.saveTokens(
        accessToken: _tokens!.accessToken,
        refreshToken: _tokens!.refreshToken,
        accessTokenExpiresIn: _tokens!.accessTokenExpiresIn,
        refreshTokenExpiresAt: _tokens!.refreshTokenExpiresAt,
      );
      await _storage.saveUserId(_user!.id);
      await _storage.saveUserEmail(_user!.email);
      await PrefsService.setFirstLaunchDone();
    }
  }

  Future<void> _clearAuth() async {
    _user = null;
    _tokens = null;
    _isAuthenticated = false;
    await _storage.clearAuth();
    notifyListeners();
  }

  Future<bool> tryAutoLogin() async {
    final userId = await _storage.getUserId();
    final refreshToken = await _storage.getRefreshToken();

    if (userId == null || refreshToken == null) {
      _error = null;
      return false;
    }

    _isAuthenticated = true;
    notifyListeners();

    return loadUser();
  }

  void clearError() {
    _setError(null);
  }
}
