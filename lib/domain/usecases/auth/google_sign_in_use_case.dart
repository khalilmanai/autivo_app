import '../../../core/network/api_client.dart';
import '../../../data/models/user.dart';
import '../../repositories/auth_repository.dart';
import '../use_case.dart';

class GoogleSignInUseCase extends UseCase<AuthResult, GoogleSignInParams> {
  final IAuthRepository _repository;

  GoogleSignInUseCase(this._repository);

  @override
  Future<Result<AuthResult>> call(GoogleSignInParams params) => _repository
      .googleSignIn(idToken: params.idToken, preferences: params.preferences);
}

class GoogleSignInParams {
  final String idToken;
  final UserPreferences? preferences;

  GoogleSignInParams({required this.idToken, this.preferences});
}
