import '../../core/network/api_client.dart';
import '../../domain/repositories/user_repository.dart';
import '../datasources/remote/user_api.dart';
import '../models/user.dart';

class UserRepository implements IUserRepository {
  final UserApi _api;

  UserRepository(this._api);

  @override
  Future<Result<UserProfile>> getProfile() => _api.getProfile();

  @override
  Future<Result<UserProfile>> updateProfile({
    String? firstName,
    String? lastName,
    String? avatar,
  }) => _api.updateProfile(
    firstName: firstName,
    lastName: lastName,
    avatar: avatar,
  );

  @override
  Future<Result<UserProfile>> updatePreferences(UserPreferences preferences) =>
      _api.updatePreferences(preferences);

  @override
  Future<Result<UserProfile>> changeEmail({
    required String newEmail,
    required String currentPassword,
  }) => _api.changeEmail(newEmail: newEmail, currentPassword: currentPassword);

  @override
  Future<Result<void>> changePassword({
    required String currentPassword,
    required String newPassword,
  }) => _api.changePassword(
    currentPassword: currentPassword,
    newPassword: newPassword,
  );
}
