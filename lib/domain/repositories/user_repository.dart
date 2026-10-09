import '../../core/network/api_client.dart';
import '../../data/models/user.dart';

abstract class IUserRepository {
  Future<Result<UserProfile>> getProfile();
  Future<Result<UserProfile>> updateProfile({
    String? firstName,
    String? lastName,
    String? avatar,
  });
  Future<Result<UserProfile>> updatePreferences(UserPreferences preferences);
  Future<Result<UserProfile>> changeEmail({
    required String newEmail,
    required String currentPassword,
  });
  Future<Result<void>> changePassword({
    required String currentPassword,
    required String newPassword,
  });
}
