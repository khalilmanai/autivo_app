import '../../../core/network/api_client.dart';
import '../../../data/models/user.dart';
import '../../repositories/auth_repository.dart';
import '../use_case.dart';

class LoginUseCase extends UseCase<AuthResult, LoginParams> {
  final IAuthRepository _repository;

  LoginUseCase(this._repository);

  @override
  Future<Result<AuthResult>> call(LoginParams params) =>
      _repository.login(email: params.email, password: params.password);
}

class LoginParams {
  final String email;
  final String password;

  LoginParams({required this.email, required this.password});
}
