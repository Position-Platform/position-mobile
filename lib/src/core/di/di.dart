import 'package:chopper/chopper.dart';
import 'package:get_it/get_it.dart';
import 'package:position/src/modules/auth/api/setting/settingApiService.dart';
import 'package:position/src/modules/auth/api/setting/settingApiServiceFactory.dart';
import 'package:position/src/modules/app/bloc/app_bloc.dart';
import 'package:position/src/modules/auth/db/setting/setting.dao.dart';
import 'package:position/src/modules/auth/repositories/setting/settingRepository.dart';
import 'package:position/src/modules/auth/repositories/setting/settingRepositoryImpl.dart';
import 'package:position/src/core/database/db.dart';
import 'package:position/src/core/helpers/network.dart';
import 'package:position/src/core/helpers/sharedpreferences.dart';
import 'package:position/src/core/services/apiService.dart';
import 'package:position/src/core/utils/configs.dart';
import 'package:position/src/modules/auth/api/auth/authApiService.dart';
import 'package:position/src/modules/auth/api/auth/authApiServiceFactory.dart';
import 'package:position/src/modules/auth/blocs/auth/auth_bloc.dart';
import 'package:position/src/modules/auth/db/user/user.dao.dart';
import 'package:position/src/modules/auth/repositories/auth/authRepository.dart';
import 'package:position/src/modules/auth/repositories/auth/authRepositoryImpl.dart';
import 'package:position/src/modules/gps/bloc/gps_bloc.dart';

final GetIt getIt = GetIt.instance;

Future<void> init() async {
  // Création du client Chopper avec les différents services et intercepteurs
  final chopper = ChopperClient(services: [
    ApiService.create(),
  ], interceptors: [
    HttpLoggingInterceptor(level: Level.body),
    CurlInterceptor(),
    HeadersInterceptor({'X-Authorization': apiKey!})
  ], converter: const JsonConverter(), errorConverter: const JsonConverter());

  // Création des instances des différents services
  final apiService = ApiService.create(chopper);

  //ApiService
  // Enregistrement des instances des différents services d'API
  getIt.registerLazySingleton<SettingApiService>(
      () => SettingApiServiceFactory(apiService));
  getIt.registerLazySingleton<AuthApiService>(
      () => AuthApiServiceFactory(apiService));

  //Utils
  // Enregistrement des instances des différents helpers
  getIt.registerLazySingleton<NetworkInfoHelper>(() => NetworkInfoHelper());
  getIt.registerLazySingleton<SharedPreferencesHelper>(
      () => SharedPreferencesHelper());

  // Database
  // Enregistrement des instances des DAO pour accéder à la base de données
  getIt.registerLazySingleton<MyDatabase>(() => MyDatabase());
  getIt.registerLazySingleton<SettingDao>(() => SettingDao(getIt()));
  getIt.registerLazySingleton<UserDao>(() => UserDao(getIt()));

  //Repository
  // Enregistrement des instances des différents repositories
  getIt.registerFactory<SettingRepository>(
    () => SettingRepositoryImpl(
      settingApiService: getIt(),
      networkInfoHelper: getIt(),
      settingDao: getIt(),
    ),
  );

  getIt.registerFactory<AuthRepository>(
    () => AuthRepositoryImpl(
        authApiService: getIt(),
        networkInfoHelper: getIt(),
        sharedPreferencesHelper: getIt(),
        userDao: getIt()),
  );

  //Bloc
  // Enregistrement des instances des différents blocs
  getIt.registerFactory<AppBloc>(() => AppBloc(
        settingRepository: getIt(),
        sharedPreferencesHelper: getIt(),
      ));
  getIt.registerFactory<GpsBloc>(() => GpsBloc());
  getIt.registerFactory<AuthBloc>(() => AuthBloc(
      authRepository: getIt(),
      sharedPreferencesHelper: getIt(),
      settingRepository: getIt()));
}
