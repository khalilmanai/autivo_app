import '../../../core/network/api_client.dart';
import '../../repositories/auth_repository.dart';
import '../use_case.dart';

class ResetPasswordUseCase extends UseCase<void, ResetPasswordParams> {
  final IAuthRepository _repository;

  ResetPasswordUseCase(this._repository);

  @override
  Future<Result<void>> call(ResetPasswordParams params) =>
      _repository.resetPassword(token: params.token, password: params.password);
}

class ResetPasswordParams {
  final String token;
  final String password;

  ResetPasswordParams({required this.token, required this.password});
}
