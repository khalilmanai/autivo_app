const String kDefaultApiBaseUrl = 'http://10.0.2.2:5000/api/v1';

const String kDevApiBaseUrl = 'http://192.168.1.21:5000/api/v1';
const String kStagingApiBaseUrl = 'https://staging-api.autivo.com/api/v1';
const String kProdApiBaseUrl = 'https://api.autivo.com/api/v1';

class ApiConfig {
  static String baseUrl = kDefaultApiBaseUrl;

  static void init() {
    final env = String.fromEnvironment('ENV', defaultValue: 'dev');
    final customUrl = String.fromEnvironment('API_BASE_URL', defaultValue: '');

    if (customUrl.isNotEmpty) {
      baseUrl = customUrl;
    } else {
      switch (env) {
        case 'staging':
          baseUrl = kStagingApiBaseUrl;
        case 'prod':
          baseUrl = kProdApiBaseUrl;
        default:
          baseUrl = kDevApiBaseUrl;
      }
    }
  }
}
