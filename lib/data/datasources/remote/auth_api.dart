import '../../../core/constants/endpoints/auth_endpoints.dart';
import '../../../core/network/api_client.dart';
import '../../models/user.dart';

class AuthApi extends BaseApi {
  AuthApi(super.dio);

  Future<Result<AuthResult>> register({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    UserPreferences? preferences,
  }) => apiPost<AuthResult>(
    AuthEndpoints.register,
    data: {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'password': password,
      if (preferences != null) 'preferences': preferences.toJson(),
    },
    fromJson: (json) => AuthResult.fromJson(json as Map<String, dynamic>),
  );

  Future<Result<AuthResult>> login({
    required String email,
    required String password,
  }) => apiPost<AuthResult>(
    AuthEndpoints.login,
    data: {'email': email, 'password': password},
    fromJson: (json) => AuthResult.fromJson(json as Map<String, dynamic>),
  );

  Future<Result<UserProfile>> getMe() => apiGet<UserProfile>(
    AuthEndpoints.me,
    fromJson: (json) => UserProfile.fromJson(json as Map<String, dynamic>),
    dataKey: 'user',
  );

  Future<Result<AuthTokens>> refresh(String refreshToken) =>
      apiPost<AuthTokens>(
        AuthEndpoints.refresh,
        data: {'refreshToken': refreshToken},
        fromJson: (json) => AuthTokens.fromJson(json as Map<String, dynamic>),
        dataKey: 'tokens',
      );

  Future<Result<void>> logout({String? refreshToken}) => apiPostVoid(
    AuthEndpoints.logout,
    data: refreshToken != null ? {'refreshToken': refreshToken} : {},
  );

  Future<Result<void>> forgotPassword(String email) =>
      apiPostVoid(AuthEndpoints.forgotPassword, data: {'email': email});

  Future<Result<void>> resetPassword({
    required String token,
    required String password,
  }) => apiPostVoid(
    AuthEndpoints.resetPassword,
    data: {'token': token, 'password': password},
  );

  Future<Result<AuthResult>> googleSignIn({
    required String idToken,
    UserPreferences? preferences,
  }) => apiPost<AuthResult>(
    AuthEndpoints.google,
    data: {
      'idToken': idToken,
      if (preferences != null) 'preferences': preferences.toJson(),
    },
    fromJson: (json) => AuthResult.fromJson(json as Map<String, dynamic>),
  );
}
