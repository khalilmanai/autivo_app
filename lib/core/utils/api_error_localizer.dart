import '../../l10n/translations/strings.g.dart';
import '../constants/app_constants.dart';

String localizeApiError(String code, Translations t, {String? fallback}) {
  switch (code) {
    // Auth
    case ErrorCodes.invalidCredentials:
      return t.errors.invalidCredentials;
    case ErrorCodes.authenticationRequired:
    case ErrorCodes.invalidAccessToken:
    case ErrorCodes.accessTokenExpired:
    case ErrorCodes.invalidRefreshToken:
    case ErrorCodes.expiredRefreshToken:
    case ErrorCodes.refreshTokenReuseDetected:
    case ErrorCodes.invalidPasswordResetToken:
    case ErrorCodes.invalidPassword:
      return t.errors.sessionExpired;
    case ErrorCodes.invalidGoogleToken:
    case ErrorCodes.googleNoEmail:
    case ErrorCodes.googleSignInDisabled:
      return t.auth.googleSignInDisabled;

    // User
    case ErrorCodes.userNotFound:
      return t.errors.userNotFound;
    case ErrorCodes.accountInactive:
      return t.errors.accountInactive;
    case ErrorCodes.emailAlreadyExists:
      return t.errors.emailAlreadyExists;

    // Car
    case ErrorCodes.carNotFound:
      return t.errors.carNotFound;
    case ErrorCodes.vinAlreadyExistsInGarage:
      return t.errors.vinAlreadyExistsInGarage;
    case ErrorCodes.invalidVinFormat:
      return t.errors.invalidVinFormat;
    case ErrorCodes.vinDecodeFailed:
      return t.errors.vinDecodeFailed;
    case ErrorCodes.maintenanceNotFound:
      return t.errors.maintenanceNotFound;

    // Permissions
    case ErrorCodes.forbidden:
    case ErrorCodes.accessDenied:
      return t.errors.accessDenied;

    // Validation
    case ErrorCodes.validationError:
      return t.errors.validationError;
    case ErrorCodes.missingParameter:
      return t.errors.missingParameter;
    case ErrorCodes.malformedJson:
      return t.errors.malformedJson;

    // Resource
    case ErrorCodes.notFound:
      return t.errors.notFound;
    case ErrorCodes.conflict:
      return t.errors.conflict;
    case ErrorCodes.rateLimitExceeded:
      return t.errors.rateLimitExceeded;

    // System
    case ErrorCodes.internalServerError:
    case ErrorCodes.routeNotFound:
      return t.errors.internalServerError;

    // Frontend-only
    case ErrorCodes.timeout:
    case ErrorCodes.networkError:
      return t.errors.networkError;

    case ErrorCodes.unknownError:
      return t.errors.unknownError;

    default:
      return fallback ?? t.errors.unknownError;
  }
}
