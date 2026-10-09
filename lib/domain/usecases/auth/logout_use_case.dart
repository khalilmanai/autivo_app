import '../../../core/network/api_client.dart';
import '../../repositories/auth_repository.dart';
import '../use_case.dart';

class LogoutUseCase extends UseCase<void, String?> {
  final IAuthRepository _repository;

  LogoutUseCase(this._repository);

  @override
  Future<Result<void>> call(String? refreshToken) =>
      _repository.logout(refreshToken: refreshToken);
}
