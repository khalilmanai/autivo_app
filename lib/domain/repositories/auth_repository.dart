import '../../core/network/api_client.dart';
import '../../data/models/user.dart';

abstract class IAuthRepository {
  Future<Result<AuthResult>> register({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    UserPreferences? preferences,
  });

  Future<Result<AuthResult>> login({
    required String email,
    required String password,
  });

  Future<Result<UserProfile>> getMe();

  Future<Result<AuthTokens>> refresh(String refreshToken);

  Future<Result<void>> logout({String? refreshToken});

  Future<Result<void>> forgotPassword(String email);

  Future<Result<void>> resetPassword({
    required String token,
    required String password,
  });

  Future<Result<AuthResult>> googleSignIn({
    required String idToken,
    UserPreferences? preferences,
  });
}
