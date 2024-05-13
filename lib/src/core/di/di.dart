import 'package:chopper/chopper.dart';
import 'package:get_it/get_it.dart';
import 'package:position/src/core/app/api/settingApiService.dart';
import 'package:position/src/core/app/api/settingApiServiceFactory.dart';
import 'package:position/src/core/app/bloc/app_bloc.dart';
import 'package:position/src/core/app/db/setting.dao.dart';
import 'package:position/src/core/app/repositories/settingRepository.dart';
import 'package:position/src/core/app/repositories/settingRepositoryImpl.dart';
import 'package:position/src/core/database/db.dart';
import 'package:position/src/core/helpers/network.dart';
import 'package:position/src/core/helpers/sharedpreferences.dart';
import 'package:position/src/core/services/apiService.dart';
import 'package:position/src/core/utils/configs.dart';

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

  //Utils
  // Enregistrement des instances des différents helpers
  getIt.registerLazySingleton<NetworkInfoHelper>(() => NetworkInfoHelper());
  getIt.registerLazySingleton<SharedPreferencesHelper>(
      () => SharedPreferencesHelper());

  // Database
  // Enregistrement des instances des DAO pour accéder à la base de données
  getIt.registerLazySingleton<MyDatabase>(() => MyDatabase());
  getIt.registerLazySingleton<SettingDao>(() => SettingDao(getIt()));

  //Repository
  // Enregistrement des instances des différents repositories
  getIt.registerFactory<SettingRepository>(
    () => SettingRepositoryImpl(
      settingApiService: getIt(),
      networkInfoHelper: getIt(),
      settingDao: getIt(),
    ),
  );

  //Bloc
  // Enregistrement des instances des différents blocs
  getIt.registerFactory<AppBloc>(() => AppBloc(
        settingRepository: getIt(),
        sharedPreferencesHelper: getIt(),
      ));
}
