import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';

import 'core/config/api_config.dart';
import 'core/localization/locale_controller.dart';
import 'core/localization/theme_controller.dart';
import 'core/network/api_client.dart';
import 'core/storage/prefs_service.dart';
import 'core/storage/secure_storage_service.dart';
import 'data/datasources/remote/auth_api.dart';
import 'data/datasources/remote/car_api.dart';
import 'data/datasources/remote/car_part_api.dart';
import 'data/datasources/remote/catalog_api.dart';
import 'data/datasources/remote/maintenance_api.dart';
import 'data/datasources/remote/user_api.dart';
import 'data/repositories/repositories_impl.dart';
import 'domain/repositories/repositories.dart';
import 'domain/usecases/usecases.dart';
import 'presentation/viewmodels/auth_viewmodel.dart';
import 'presentation/viewmodels/car_part_viewmodel.dart';
import 'presentation/viewmodels/catalog_viewmodel.dart';
import 'presentation/viewmodels/garage_viewmodel.dart';
import 'presentation/viewmodels/maintenance_viewmodel.dart';
import 'presentation/viewmodels/user_viewmodel.dart';

final getIt = GetIt.instance;

Future<void> setupDependencies() async {
  // Environment config
  ApiConfig.init();

  // Core services
  await PrefsService.init();

  getIt.registerLazySingleton<SecureStorageService>(
    () => SecureStorageService(),
  );
  getIt.registerLazySingleton<PrefsService>(() => PrefsService());
  getIt.registerLazySingleton<LocaleController>(() => LocaleController());
  getIt.registerLazySingleton<ThemeController>(() => ThemeController());

  // Dio
  final dio = Dio(
    BaseOptions(
      baseUrl: ApiConfig.baseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      headers: {'Content-Type': 'application/json'},
    ),
  );

  // APIs
  final authApi = AuthApi(dio);
  getIt.registerLazySingleton<AuthApi>(() => authApi);
  getIt.registerLazySingleton<UserApi>(() => UserApi(dio));
  getIt.registerLazySingleton<CarApi>(() => CarApi(dio));
  getIt.registerLazySingleton<CarPartApi>(() => CarPartApi(dio));
  getIt.registerLazySingleton<MaintenanceApi>(() => MaintenanceApi(dio));
  getIt.registerLazySingleton<CatalogApi>(() => CatalogApi(dio));

  // Auth interceptor (uses AuthApi for refresh)
  final authInterceptor = AuthInterceptor(
    getIt<SecureStorageService>(),
    (refreshToken) async {
      final result = await authApi.refresh(refreshToken);
      if (result.isFailure) throw Exception('Refresh failed');
      final tokens = result.data!;
      await getIt<SecureStorageService>().saveTokens(
        accessToken: tokens.accessToken,
        refreshToken: tokens.refreshToken,
        accessTokenExpiresIn: tokens.accessTokenExpiresIn,
        refreshTokenExpiresAt: tokens.refreshTokenExpiresAt,
      );
    },
    onAuthCleared: () => getIt<AuthViewModel>().forceLogout(),
  );
  authInterceptor.setDio(dio);
  dio.interceptors.add(authInterceptor);
  if (kDebugMode) {
    dio.interceptors.add(
      LogInterceptor(
        request: true,
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
        responseBody: true,
        error: true,
      ),
    );
  }

  getIt.registerLazySingleton<Dio>(() => dio);

  // Repositories
  getIt.registerLazySingleton<IAuthRepository>(
    () => AuthRepository(getIt<AuthApi>()),
  );
  getIt.registerLazySingleton<IUserRepository>(
    () => UserRepository(getIt<UserApi>()),
  );
  getIt.registerLazySingleton<ICarRepository>(
    () => CarRepository(getIt<CarApi>()),
  );
  getIt.registerLazySingleton<ICarPartRepository>(
    () => CarPartRepository(getIt<CarPartApi>()),
  );
  getIt.registerLazySingleton<IMaintenanceRepository>(
    () => MaintenanceRepository(getIt<MaintenanceApi>()),
  );
  getIt.registerLazySingleton<ICatalogRepository>(
    () => CatalogRepository(getIt<CatalogApi>()),
  );

  // Use cases
  getIt.registerLazySingleton<RegisterUseCase>(
    () => RegisterUseCase(getIt<IAuthRepository>()),
  );
  getIt.registerLazySingleton<LoginUseCase>(
    () => LoginUseCase(getIt<IAuthRepository>()),
  );
  getIt.registerLazySingleton<GetMeUseCase>(
    () => GetMeUseCase(getIt<IAuthRepository>()),
  );
  getIt.registerLazySingleton<RefreshTokenUseCase>(
    () => RefreshTokenUseCase(getIt<IAuthRepository>()),
  );
  getIt.registerLazySingleton<LogoutUseCase>(
    () => LogoutUseCase(getIt<IAuthRepository>()),
  );
  getIt.registerLazySingleton<ForgotPasswordUseCase>(
    () => ForgotPasswordUseCase(getIt<IAuthRepository>()),
  );
  getIt.registerLazySingleton<ResetPasswordUseCase>(
    () => ResetPasswordUseCase(getIt<IAuthRepository>()),
  );
  getIt.registerLazySingleton<GoogleSignInUseCase>(
    () => GoogleSignInUseCase(getIt<IAuthRepository>()),
  );

  getIt.registerLazySingleton<GetProfileUseCase>(
    () => GetProfileUseCase(getIt<IUserRepository>()),
  );
  getIt.registerLazySingleton<UpdateProfileUseCase>(
    () => UpdateProfileUseCase(getIt<IUserRepository>()),
  );
  getIt.registerLazySingleton<UpdatePreferencesUseCase>(
    () => UpdatePreferencesUseCase(getIt<IUserRepository>()),
  );
  getIt.registerLazySingleton<ChangeEmailUseCase>(
    () => ChangeEmailUseCase(getIt<IUserRepository>()),
  );
  getIt.registerLazySingleton<ChangePasswordUseCase>(
    () => ChangePasswordUseCase(getIt<IUserRepository>()),
  );

  getIt.registerLazySingleton<CreateCarUseCase>(
    () => CreateCarUseCase(getIt<ICarRepository>()),
  );
  getIt.registerLazySingleton<ListCarsUseCase>(
    () => ListCarsUseCase(getIt<ICarRepository>()),
  );
  getIt.registerLazySingleton<GetCarUseCase>(
    () => GetCarUseCase(getIt<ICarRepository>()),
  );
  getIt.registerLazySingleton<UpdateCarUseCase>(
    () => UpdateCarUseCase(getIt<ICarRepository>()),
  );
  getIt.registerLazySingleton<DeleteCarUseCase>(
    () => DeleteCarUseCase(getIt<ICarRepository>()),
  );
  getIt.registerLazySingleton<DecodeVinUseCase>(
    () => DecodeVinUseCase(getIt<ICarRepository>()),
  );

  getIt.registerLazySingleton<ListCarPartsUseCase>(
    () => ListCarPartsUseCase(getIt<ICarPartRepository>()),
  );
  getIt.registerLazySingleton<GetCarPartUseCase>(
    () => GetCarPartUseCase(getIt<ICarPartRepository>()),
  );
  getIt.registerLazySingleton<UpsertCarPartUseCase>(
    () => UpsertCarPartUseCase(getIt<ICarPartRepository>()),
  );
  getIt.registerLazySingleton<DeleteCarPartUseCase>(
    () => DeleteCarPartUseCase(getIt<ICarPartRepository>()),
  );

  getIt.registerLazySingleton<ListMaintenanceUseCase>(
    () => ListMaintenanceUseCase(getIt<IMaintenanceRepository>()),
  );
  getIt.registerLazySingleton<GetMaintenanceUseCase>(
    () => GetMaintenanceUseCase(getIt<IMaintenanceRepository>()),
  );
  getIt.registerLazySingleton<CreateMaintenanceUseCase>(
    () => CreateMaintenanceUseCase(getIt<IMaintenanceRepository>()),
  );
  getIt.registerLazySingleton<UpdateMaintenanceUseCase>(
    () => UpdateMaintenanceUseCase(getIt<IMaintenanceRepository>()),
  );
  getIt.registerLazySingleton<DeleteMaintenanceUseCase>(
    () => DeleteMaintenanceUseCase(getIt<IMaintenanceRepository>()),
  );

  getIt.registerLazySingleton<GetMakesUseCase>(
    () => GetMakesUseCase(getIt<ICatalogRepository>()),
  );
  getIt.registerLazySingleton<GetModelsUseCase>(
    () => GetModelsUseCase(getIt<ICatalogRepository>()),
  );
  getIt.registerLazySingleton<GetConfigurationsUseCase>(
    () => GetConfigurationsUseCase(getIt<ICatalogRepository>()),
  );
  getIt.registerLazySingleton<GetEnginesUseCase>(
    () => GetEnginesUseCase(getIt<ICatalogRepository>()),
  );
  getIt.registerLazySingleton<GetTransmissionsUseCase>(
    () => GetTransmissionsUseCase(getIt<ICatalogRepository>()),
  );
  getIt.registerLazySingleton<GetSpecsUseCase>(
    () => GetSpecsUseCase(getIt<ICatalogRepository>()),
  );
  getIt.registerLazySingleton<GetYearsUseCase>(
    () => GetYearsUseCase(getIt<ICatalogRepository>()),
  );

  // ViewModels
  getIt.registerLazySingleton<AuthViewModel>(
    () => AuthViewModel(
      getIt<RegisterUseCase>(),
      getIt<LoginUseCase>(),
      getIt<GetMeUseCase>(),
      getIt<RefreshTokenUseCase>(),
      getIt<LogoutUseCase>(),
      getIt<ForgotPasswordUseCase>(),
      getIt<ResetPasswordUseCase>(),
      getIt<GoogleSignInUseCase>(),
      getIt<SecureStorageService>(),
    ),
  );

  getIt.registerFactory<UserViewModel>(
    () => UserViewModel(
      getIt<GetProfileUseCase>(),
      getIt<UpdateProfileUseCase>(),
      getIt<UpdatePreferencesUseCase>(),
      getIt<ChangeEmailUseCase>(),
      getIt<ChangePasswordUseCase>(),
    ),
  );

  getIt.registerFactory<GarageViewModel>(
    () => GarageViewModel(
      getIt<CreateCarUseCase>(),
      getIt<ListCarsUseCase>(),
      getIt<GetCarUseCase>(),
      getIt<UpdateCarUseCase>(),
      getIt<DeleteCarUseCase>(),
      getIt<DecodeVinUseCase>(),
    ),
  );

  getIt.registerFactory<CarPartViewModel>(
    () => CarPartViewModel(
      getIt<ListCarPartsUseCase>(),
      getIt<GetCarPartUseCase>(),
      getIt<UpsertCarPartUseCase>(),
      getIt<DeleteCarPartUseCase>(),
    ),
  );

  getIt.registerFactory<MaintenanceViewModel>(
    () => MaintenanceViewModel(
      getIt<ListMaintenanceUseCase>(),
      getIt<GetMaintenanceUseCase>(),
      getIt<CreateMaintenanceUseCase>(),
      getIt<UpdateMaintenanceUseCase>(),
      getIt<DeleteMaintenanceUseCase>(),
    ),
  );

  getIt.registerFactory<CatalogViewModel>(
    () => CatalogViewModel(
      getIt<GetMakesUseCase>(),
      getIt<GetModelsUseCase>(),
      getIt<GetConfigurationsUseCase>(),
      getIt<GetEnginesUseCase>(),
      getIt<GetTransmissionsUseCase>(),
      getIt<GetSpecsUseCase>(),
      getIt<GetYearsUseCase>(),
    ),
  );
}
