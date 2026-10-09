import '../../../core/network/api_client.dart';
import '../../repositories/auth_repository.dart';
import '../use_case.dart';

class ForgotPasswordUseCase extends UseCase<void, String> {
  final IAuthRepository _repository;

  ForgotPasswordUseCase(this._repository);

  @override
  Future<Result<void>> call(String email) => _repository.forgotPassword(email);
}
