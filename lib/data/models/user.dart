import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class UserPreferences extends Equatable {
  final String language;
  final String distanceUnit;
  final String currency;

  const UserPreferences({
    required this.language,
    required this.distanceUnit,
    required this.currency,
  });

  factory UserPreferences.fromJson(Map<String, dynamic> json) =>
      _$UserPreferencesFromJson(json);
  Map<String, dynamic> toJson() => _$UserPreferencesToJson(this);

  const UserPreferences.defaults()
    : language = 'en',
      distanceUnit = 'km',
      currency = 'TND';

  UserPreferences copyWith({
    String? language,
    String? distanceUnit,
    String? currency,
  }) => UserPreferences(
    language: language ?? this.language,
    distanceUnit: distanceUnit ?? this.distanceUnit,
    currency: currency ?? this.currency,
  );

  @override
  List<Object?> get props => [language, distanceUnit, currency];
}

@JsonSerializable()
class UserProfile extends Equatable {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String? avatar;
  final bool isEmailVerified;
  final bool isActive;
  final String authProvider;
  final UserPreferences preferences;
  final DateTime createdAt;
  final DateTime updatedAt;

  const UserProfile({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.isEmailVerified,
    required this.isActive,
    required this.authProvider,
    required this.preferences,
    required this.createdAt,
    required this.updatedAt,
    this.avatar,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) =>
      _$UserProfileFromJson(json);
  Map<String, dynamic> toJson() => _$UserProfileToJson(this);

  String get fullName => '$firstName $lastName';

  @override
  List<Object?> get props => [
    id,
    firstName,
    lastName,
    email,
    avatar,
    isEmailVerified,
    isActive,
    authProvider,
    preferences,
    createdAt,
    updatedAt,
  ];
}

@JsonSerializable()
class AuthTokens extends Equatable {
  final String accessToken;
  final String refreshToken;
  final String tokenType;
  final int accessTokenExpiresIn;
  final String refreshTokenExpiresAt;

  const AuthTokens({
    required this.accessToken,
    required this.refreshToken,
    required this.tokenType,
    required this.accessTokenExpiresIn,
    required this.refreshTokenExpiresAt,
  });

  factory AuthTokens.fromJson(Map<String, dynamic> json) =>
      _$AuthTokensFromJson(json);
  Map<String, dynamic> toJson() => _$AuthTokensToJson(this);

  @override
  List<Object?> get props => [
    accessToken,
    refreshToken,
    tokenType,
    accessTokenExpiresIn,
    refreshTokenExpiresAt,
  ];
}

@JsonSerializable()
class AuthResult extends Equatable {
  final UserProfile user;
  final AuthTokens tokens;

  const AuthResult({required this.user, required this.tokens});

  factory AuthResult.fromJson(Map<String, dynamic> json) =>
      _$AuthResultFromJson(json);
  Map<String, dynamic> toJson() => _$AuthResultToJson(this);

  @override
  List<Object?> get props => [user, tokens];
}
