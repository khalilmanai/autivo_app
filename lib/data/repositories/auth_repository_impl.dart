import '../../core/network/api_client.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/remote/auth_api.dart';
import '../models/user.dart';

class AuthRepository implements IAuthRepository {
  final AuthApi _api;

  AuthRepository(this._api);

  @override
  Future<Result<AuthResult>> register({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    UserPreferences? preferences,
  }) => _api.register(
    firstName: firstName,
    lastName: lastName,
    email: email,
    password: password,
    preferences: preferences,
  );

  @override
  Future<Result<AuthResult>> login({
    required String email,
    required String password,
  }) => _api.login(email: email, password: password);

  @override
  Future<Result<UserProfile>> getMe() => _api.getMe();

  @override
  Future<Result<AuthTokens>> refresh(String refreshToken) =>
      _api.refresh(refreshToken);

  @override
  Future<Result<void>> logout({String? refreshToken}) =>
      _api.logout(refreshToken: refreshToken);

  @override
  Future<Result<void>> forgotPassword(String email) =>
      _api.forgotPassword(email);

  @override
  Future<Result<void>> resetPassword({
    required String token,
    required String password,
  }) => _api.resetPassword(token: token, password: password);

  @override
  Future<Result<AuthResult>> googleSignIn({
    required String idToken,
    UserPreferences? preferences,
  }) => _api.googleSignIn(idToken: idToken, preferences: preferences);
}
