import '../../../core/constants/endpoints/user_endpoints.dart';
import '../../../core/network/api_client.dart';
import '../../models/user.dart';

class UserApi extends BaseApi {
  UserApi(super.dio);

  Future<Result<UserProfile>> getProfile() => apiGet<UserProfile>(
    UserEndpoints.me,
    fromJson: (json) => UserProfile.fromJson(json as Map<String, dynamic>),
    dataKey: 'user',
  );

  Future<Result<UserProfile>> updateProfile({
    String? firstName,
    String? lastName,
    String? avatar,
  }) => apiPatch<UserProfile>(
    UserEndpoints.me,
    data: {'firstName': ?firstName, 'lastName': ?lastName, 'avatar': ?avatar},
    fromJson: (json) => UserProfile.fromJson(json as Map<String, dynamic>),
    dataKey: 'user',
  );

  Future<Result<UserProfile>> updatePreferences(UserPreferences preferences) =>
      apiPatch<UserProfile>(
        UserEndpoints.updatePreferences,
        data: {'preferences': preferences.toJson()},
        fromJson: (json) => UserProfile.fromJson(json as Map<String, dynamic>),
        dataKey: 'user',
      );

  Future<Result<UserProfile>> changeEmail({
    required String newEmail,
    required String currentPassword,
  }) => apiPut<UserProfile>(
    UserEndpoints.changeEmail,
    data: {'newEmail': newEmail, 'currentPassword': currentPassword},
    fromJson: (json) => UserProfile.fromJson(json as Map<String, dynamic>),
    dataKey: 'user',
  );

  Future<Result<void>> changePassword({
    required String currentPassword,
    required String newPassword,
  }) => apiPut<void>(
    UserEndpoints.changePassword,
    data: {'currentPassword': currentPassword, 'newPassword': newPassword},
    fromJson: (_) {},
  );
}
