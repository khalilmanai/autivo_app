import 'package:flutter/material.dart';

import '../../core/network/api_exception.dart';
import '../../data/models/user.dart';
import '../../domain/usecases/usecases.dart';

class UserViewModel extends ChangeNotifier {
  final GetProfileUseCase _getProfileUseCase;
  final UpdateProfileUseCase _updateProfileUseCase;
  final UpdatePreferencesUseCase _updatePreferencesUseCase;
  final ChangeEmailUseCase _changeEmailUseCase;
  final ChangePasswordUseCase _changePasswordUseCase;

  UserViewModel(
    this._getProfileUseCase,
    this._updateProfileUseCase,
    this._updatePreferencesUseCase,
    this._changeEmailUseCase,
    this._changePasswordUseCase,
  );

  bool _isLoading = false;
  ApiException? _error;
  UserProfile? _user;

  bool get isLoading => _isLoading;
  ApiException? get error => _error;
  UserProfile? get user => _user;

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

  Future<bool> loadProfile() async {
    _setLoading(true);
    _setError(null);

    final result = await _getProfileUseCase(null);
    _setLoading(false);

    if (result.isSuccess) {
      _user = result.data;
      notifyListeners();
      return true;
    } else {
      _setError(result.error!);
      return false;
    }
  }

  Future<bool> updateProfile({
    String? firstName,
    String? lastName,
    String? avatar,
  }) async {
    _setLoading(true);
    _setError(null);

    final result = await _updateProfileUseCase(
      UpdateProfileParams(
        firstName: firstName,
        lastName: lastName,
        avatar: avatar,
      ),
    );

    _setLoading(false);

    if (result.isSuccess) {
      _user = result.data;
      notifyListeners();
      return true;
    } else {
      _setError(result.error!);
      return false;
    }
  }

  Future<bool> updatePreferences(UserPreferences preferences) async {
    _setLoading(true);
    _setError(null);

    final result = await _updatePreferencesUseCase(preferences);
    _setLoading(false);

    if (result.isSuccess) {
      _user = result.data;
      notifyListeners();
      return true;
    } else {
      _setError(result.error!);
      return false;
    }
  }

  Future<bool> changeEmail({
    required String newEmail,
    required String currentPassword,
  }) async {
    _setLoading(true);
    _setError(null);

    final result = await _changeEmailUseCase(
      ChangeEmailParams(newEmail: newEmail, currentPassword: currentPassword),
    );

    _setLoading(false);

    if (result.isSuccess) {
      _user = result.data;
      notifyListeners();
      return true;
    } else {
      _setError(result.error!);
      return false;
    }
  }

  Future<bool> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    _setLoading(true);
    _setError(null);

    final result = await _changePasswordUseCase(
      ChangePasswordParams(
        currentPassword: currentPassword,
        newPassword: newPassword,
      ),
    );

    _setLoading(false);

    if (result.isSuccess) {
      return true;
    } else {
      _setError(result.error!);
      return false;
    }
  }

  void clearError() => _setError(null);

  void updateUser(UserProfile user) {
    _user = user;
    notifyListeners();
  }
}
