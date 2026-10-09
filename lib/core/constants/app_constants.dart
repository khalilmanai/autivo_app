const String kAppName = 'Autivo';
const String kAppVersion = '1.0.0';

class ErrorCodes {
  // Auth
  static const String invalidCredentials = 'INVALID_CREDENTIALS';
  static const String authenticationRequired = 'AUTHENTICATION_REQUIRED';
  static const String unauthorized = 'UNAUTHORIZED';
  static const String invalidAccessToken = 'INVALID_ACCESS_TOKEN';
  static const String accessTokenExpired = 'ACCESS_TOKEN_EXPIRED';
  static const String invalidRefreshToken = 'INVALID_REFRESH_TOKEN';
  static const String expiredRefreshToken = 'EXPIRED_REFRESH_TOKEN';
  static const String refreshTokenReuseDetected =
      'REFRESH_TOKEN_REUSE_DETECTED';
  static const String invalidPasswordResetToken =
      'INVALID_PASSWORD_RESET_TOKEN';
  static const String invalidPassword = 'INVALID_PASSWORD';
  static const String invalidGoogleToken = 'INVALID_GOOGLE_TOKEN';
  static const String googleNoEmail = 'GOOGLE_NO_EMAIL';

  // User
  static const String userNotFound = 'USER_NOT_FOUND';
  static const String accountInactive = 'ACCOUNT_INACTIVE';
  static const String emailAlreadyExists = 'EMAIL_ALREADY_EXISTS';

  // Car
  static const String carNotFound = 'CAR_NOT_FOUND';
  static const String vinAlreadyExistsInGarage = 'VIN_ALREADY_EXISTS_IN_GARAGE';
  static const String invalidVinFormat = 'INVALID_VIN_FORMAT';
  static const String vinDecodeFailed = 'VIN_DECODE_FAILED';
  static const String maintenanceNotFound = 'MAINTENANCE_NOT_FOUND';

  // Permissions
  static const String forbidden = 'FORBIDDEN';
  static const String accessDenied = 'ACCESS_DENIED';
  static const String googleSignInDisabled = 'GOOGLE_SIGN_IN_DISABLED';

  // Validation / Client
  static const String validationError = 'VALIDATION_ERROR';
  static const String missingParameter = 'MISSING_PARAMETER';
  static const String malformedJson = 'MALFORMED_JSON';

  // Resource
  static const String notFound = 'NOT_FOUND';
  static const String conflict = 'CONFLICT';
  static const String rateLimitExceeded = 'RATE_LIMIT_EXCEEDED';

  // System
  static const String internalServerError = 'INTERNAL_SERVER_ERROR';
  static const String routeNotFound = 'ROUTE_NOT_FOUND';

  // Frontend-only
  static const String timeout = 'TIMEOUT';
  static const String networkError = 'NETWORK_ERROR';
  static const String unknownError = 'UNKNOWN_ERROR';
}

class PreferencesKeys {
  static const String language = 'language';
  static const String distanceUnit = 'distanceUnit';
  static const String currency = 'currency';
  static const String themeMode = 'themeMode';
  static const String firstLaunch = 'firstLaunch';
}

class StorageKeys {
  static const String accessToken = 'access_token';
  static const String refreshToken = 'refresh_token';
  static const String accessTokenExpiresAt = 'access_token_expires_at';
  static const String refreshTokenExpiresAt = 'refresh_token_expires_at';
  static const String userId = 'user_id';
  static const String userEmail = 'user_email';
}

class SupportedLanguages {
  static const List<String> codes = ['en', 'fr', 'ar'];
  static const Map<String, String> names = {
    'en': 'English',
    'fr': 'Français',
    'ar': 'العربية',
  };
}

class FuelTypes {
  static const List<String> values = [
    'gasoline',
    'diesel',
    'electric',
    'hybrid',
    'flex_fuel',
  ];
  static const Map<String, String> labels = {
    'gasoline': 'Petrol',
    'diesel': 'Diesel',
    'electric': 'Electric',
    'hybrid': 'Hybrid',
    'flex_fuel': 'Flex Fuel',
  };
}

class CarStatuses {
  static const List<String> values = ['active', 'maintenance', 'inactive'];
  static const Map<String, String> labels = {
    'active': 'Active',
    'maintenance': 'Maintenance Due',
    'inactive': 'Inactive',
  };
}

class PartStatuses {
  static const List<String> values = [
    'original',
    'replaced',
    'serviced',
    'worn',
    'damaged',
  ];
  static const Map<String, String> labels = {
    'original': 'Original',
    'replaced': 'Replaced',
    'serviced': 'Serviced',
    'worn': 'Worn',
    'damaged': 'Damaged',
  };
}

class ValidPartIds {
  static const List<String> values = [
    'engine',
    'battery',
    'alternator',
    'radiator',
    'air-filter',
    'oil-filter',
    'belts',
    'transmission',
    'front-left-brake',
    'front-right-brake',
    'rear-left-brake',
    'rear-right-brake',
    'front-left-suspension',
    'front-right-suspension',
    'rear-left-suspension',
    'rear-right-suspension',
    'front-left-tire',
    'front-right-tire',
    'rear-left-tire',
    'rear-right-tire',
    'exhaust',
    'fuel-system',
    'cooling',
    'steering',
    'headlights',
    'tail-lights',
    'body-front',
    'body-rear',
    'interior',
    'electrical',
  ];

  static const Map<String, String> labels = {
    'engine': 'Engine',
    'battery': 'Battery',
    'alternator': 'Alternator',
    'radiator': 'Radiator',
    'air-filter': 'Air Filter',
    'oil-filter': 'Oil Filter',
    'belts': 'Belts',
    'transmission': 'Transmission',
    'front-left-brake': 'Front Left Brake',
    'front-right-brake': 'Front Right Brake',
    'rear-left-brake': 'Rear Left Brake',
    'rear-right-brake': 'Rear Right Brake',
    'front-left-suspension': 'Front Left Suspension',
    'front-right-suspension': 'Front Right Suspension',
    'rear-left-suspension': 'Rear Left Suspension',
    'rear-right-suspension': 'Rear Right Suspension',
    'front-left-tire': 'Front Left Tire',
    'front-right-tire': 'Front Right Tire',
    'rear-left-tire': 'Rear Left Tire',
    'rear-right-tire': 'Rear Right Tire',
    'exhaust': 'Exhaust',
    'fuel-system': 'Fuel System',
    'cooling': 'Cooling System',
    'steering': 'Steering',
    'headlights': 'Headlights',
    'tail-lights': 'Tail Lights',
    'body-front': 'Front Body',
    'body-rear': 'Rear Body',
    'interior': 'Interior',
    'electrical': 'Electrical System',
  };

  static const Map<String, String> groups = {
    'engine': 'engineParts',
    'battery': 'engineParts',
    'alternator': 'engineParts',
    'radiator': 'engineParts',
    'air-filter': 'engineParts',
    'oil-filter': 'engineParts',
    'belts': 'engineParts',
    'transmission': 'engineParts',
    'front-left-brake': 'brakeParts',
    'front-right-brake': 'brakeParts',
    'rear-left-brake': 'brakeParts',
    'rear-right-brake': 'brakeParts',
    'front-left-suspension': 'suspensionParts',
    'front-right-suspension': 'suspensionParts',
    'rear-left-suspension': 'suspensionParts',
    'rear-right-suspension': 'suspensionParts',
    'front-left-tire': 'tireParts',
    'front-right-tire': 'tireParts',
    'rear-left-tire': 'tireParts',
    'rear-right-tire': 'tireParts',
    'exhaust': 'bodyParts',
    'fuel-system': 'engineParts',
    'cooling': 'engineParts',
    'steering': 'bodyParts',
    'headlights': 'bodyParts',
    'tail-lights': 'bodyParts',
    'body-front': 'bodyParts',
    'body-rear': 'bodyParts',
    'interior': 'bodyParts',
    'electrical': 'electricalParts',
  };
}

class MaintenanceTypes {
  static const List<String> values = [
    'maintenance',
    'repair',
    'paint',
    'accident',
    'fuel',
    'document',
    'inspection',
    'modification',
    'tires',
    'battery',
    'electrical',
  ];
  static const Map<String, String> labels = {
    'maintenance': 'Maintenance',
    'repair': 'Repair',
    'paint': 'Paint & Body',
    'accident': 'Accident',
    'fuel': 'Fuel',
    'document': 'Document',
    'inspection': 'Inspection',
    'modification': 'Modification',
    'tires': 'Tires',
    'battery': 'Battery',
    'electrical': 'Electrical',
  };
}
