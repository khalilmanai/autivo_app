import '../../../core/network/api_client.dart';
import '../../../data/models/user.dart';
import '../../repositories/auth_repository.dart';
import '../use_case.dart';

class GetMeUseCase extends UseCase<UserProfile, void> {
  final IAuthRepository _repository;

  GetMeUseCase(this._repository);

  @override
  Future<Result<UserProfile>> call(void _) => _repository.getMe();
}
