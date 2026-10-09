import '../../../core/network/api_client.dart';
import '../../../data/models/user.dart';
import '../../repositories/auth_repository.dart';
import '../use_case.dart';

class RefreshTokenUseCase extends UseCase<AuthTokens, String> {
  final IAuthRepository _repository;

  RefreshTokenUseCase(this._repository);

  @override
  Future<Result<AuthTokens>> call(String refreshToken) =>
      _repository.refresh(refreshToken);
}
