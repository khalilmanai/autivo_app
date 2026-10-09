import '../../../core/network/api_client.dart';
import '../../../data/models/user.dart';
import '../../repositories/user_repository.dart';
import '../use_case.dart';

class GetProfileUseCase extends UseCase<UserProfile, void> {
  final IUserRepository _repository;

  GetProfileUseCase(this._repository);

  @override
  Future<Result<UserProfile>> call(void _) => _repository.getProfile();
}

class UpdateProfileUseCase extends UseCase<UserProfile, UpdateProfileParams> {
  final IUserRepository _repository;

  UpdateProfileUseCase(this._repository);

  @override
  Future<Result<UserProfile>> call(UpdateProfileParams params) =>
      _repository.updateProfile(
        firstName: params.firstName,
        lastName: params.lastName,
        avatar: params.avatar,
      );
}

class UpdateProfileParams {
  final String? firstName;
  final String? lastName;
  final String? avatar;

  UpdateProfileParams({this.firstName, this.lastName, this.avatar});
}

class UpdatePreferencesUseCase extends UseCase<UserProfile, UserPreferences> {
  final IUserRepository _repository;

  UpdatePreferencesUseCase(this._repository);

  @override
  Future<Result<UserProfile>> call(UserPreferences preferences) =>
      _repository.updatePreferences(preferences);
}

class ChangeEmailUseCase extends UseCase<UserProfile, ChangeEmailParams> {
  final IUserRepository _repository;

  ChangeEmailUseCase(this._repository);

  @override
  Future<Result<UserProfile>> call(ChangeEmailParams params) =>
      _repository.changeEmail(
        newEmail: params.newEmail,
        currentPassword: params.currentPassword,
      );
}

class ChangeEmailParams {
  final String newEmail;
  final String currentPassword;

  ChangeEmailParams({required this.newEmail, required this.currentPassword});
}

class ChangePasswordUseCase extends UseCase<void, ChangePasswordParams> {
  final IUserRepository _repository;

  ChangePasswordUseCase(this._repository);

  @override
  Future<Result<void>> call(ChangePasswordParams params) =>
      _repository.changePassword(
        currentPassword: params.currentPassword,
        newPassword: params.newPassword,
      );
}

class ChangePasswordParams {
  final String currentPassword;
  final String newPassword;

  ChangePasswordParams({
    required this.currentPassword,
    required this.newPassword,
  });
}
