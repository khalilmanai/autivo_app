import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../core/constants/app_constants.dart';

class SecureStorageService {
  static const _storage = FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
    iOptions: IOSOptions(
      accessibility: KeychainAccessibility.first_unlock_this_device,
    ),
  );

  Future<void> saveTokens({
    required String accessToken,
    required String refreshToken,
    required int accessTokenExpiresIn,
    required String refreshTokenExpiresAt,
  }) async {
    final now = DateTime.now().millisecondsSinceEpoch;
    final accessExpiresAt = now + (accessTokenExpiresIn * 1000);

    await Future.wait([
      _storage.write(key: StorageKeys.accessToken, value: accessToken),
      _storage.write(key: StorageKeys.refreshToken, value: refreshToken),
      _storage.write(
        key: StorageKeys.accessTokenExpiresAt,
        value: accessExpiresAt.toString(),
      ),
      _storage.write(
        key: StorageKeys.refreshTokenExpiresAt,
        value: refreshTokenExpiresAt,
      ),
    ]);
  }

  Future<String?> getAccessToken() async =>
      _storage.read(key: StorageKeys.accessToken);
  Future<String?> getRefreshToken() async =>
      _storage.read(key: StorageKeys.refreshToken);

  Future<bool> isAccessTokenExpired() async {
    final expiresAtStr = await _storage.read(
      key: StorageKeys.accessTokenExpiresAt,
    );
    if (expiresAtStr == null) return true;
    final expiresAt = int.tryParse(expiresAtStr) ?? 0;
    return DateTime.now().millisecondsSinceEpoch >= expiresAt;
  }

  Future<void> clearAuth() async {
    await Future.wait([
      _storage.delete(key: StorageKeys.accessToken),
      _storage.delete(key: StorageKeys.refreshToken),
      _storage.delete(key: StorageKeys.accessTokenExpiresAt),
      _storage.delete(key: StorageKeys.refreshTokenExpiresAt),
      _storage.delete(key: StorageKeys.userId),
      _storage.delete(key: StorageKeys.userEmail),
    ]);
  }

  Future<void> saveUserId(String userId) async =>
      _storage.write(key: StorageKeys.userId, value: userId);
  Future<String?> getUserId() async => _storage.read(key: StorageKeys.userId);

  Future<void> saveUserEmail(String email) async =>
      _storage.write(key: StorageKeys.userEmail, value: email);
  Future<String?> getUserEmail() async =>
      _storage.read(key: StorageKeys.userEmail);
}
