import '../../../core/network/api_client.dart';
import '../../../data/models/user.dart';
import '../../repositories/auth_repository.dart';
import '../use_case.dart';

class RegisterUseCase extends UseCase<AuthResult, RegisterParams> {
  final IAuthRepository _repository;

  RegisterUseCase(this._repository);

  @override
  Future<Result<AuthResult>> call(RegisterParams params) =>
      _repository.register(
        firstName: params.firstName,
        lastName: params.lastName,
        email: params.email,
        password: params.password,
        preferences: params.preferences,
      );
}

class RegisterParams {
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final UserPreferences? preferences;

  RegisterParams({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    this.preferences,
  });
}
