import 'package:chopper/chopper.dart';
import 'package:get_it/get_it.dart';
import 'package:position/src/modules/auth/api/setting/settingApiService.dart';
import 'package:position/src/modules/auth/api/setting/settingApiServiceFactory.dart';
import 'package:position/src/modules/app/bloc/app_bloc.dart';
import 'package:position/src/modules/auth/blocs/login/login_bloc.dart';
import 'package:position/src/modules/auth/blocs/register/register_bloc.dart';
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
import 'package:position/src/modules/categories/api/categoriesApiService.dart';
import 'package:position/src/modules/categories/api/categoriesApiServiceFactory.dart';
import 'package:position/src/modules/categories/bloc/categories/categories_bloc.dart';
import 'package:position/src/modules/categories/db/category.dao.dart';
import 'package:position/src/modules/categories/repositories/categoriesRepository.dart';
import 'package:position/src/modules/categories/repositories/categoriesRepositoryImpl.dart';
import 'package:position/src/modules/gps/bloc/gps_bloc.dart';
import 'package:position/src/modules/map/bloc/map/map_bloc.dart';
import 'package:position/src/modules/search/api/searchApiService.dart';
import 'package:position/src/modules/search/api/searchApiServiceFactory.dart';
import 'package:position/src/modules/search/bloc/bloc/search_bloc.dart';
import 'package:position/src/modules/search/repositories/searchRepository.dart';
import 'package:position/src/modules/search/repositories/searchRepositoryImpl.dart';

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
  getIt.registerLazySingleton<CategoriesApiService>(
      () => CategoriesApiServiceFactory(apiService));
  getIt.registerLazySingleton<SearchApiService>(
      () => SearchApiServiceFactory(apiService));

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
  getIt.registerLazySingleton<CategoryDao>(() => CategoryDao(getIt()));

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

  getIt.registerFactory<CategoriesRepository>(
    () => CategoriesRepositoryImpl(
        categoriesApiService: getIt(),
        networkInfoHelper: getIt(),
        sharedPreferencesHelper: getIt(),
        categoryDao: getIt()),
  );

  getIt.registerFactory<SearchRepository>(
    () => SearchRepositoryImpl(
      searchApiService: getIt(),
      networkInfoHelper: getIt(),
    ),
  );

  //Bloc
  // Enregistrement des instances des différents blocs
  getIt.registerFactory<AppBloc>(() => AppBloc());
  getIt.registerFactory<GpsBloc>(() => GpsBloc());
  getIt.registerFactory<AuthBloc>(() => AuthBloc(
      authRepository: getIt(),
      sharedPreferencesHelper: getIt(),
      settingRepository: getIt()));
  getIt.registerFactory<LoginBloc>(() =>
      LoginBloc(authRepository: getIt(), sharedPreferencesHelper: getIt()));
  getIt.registerFactory<RegisterBloc>(() =>
      RegisterBloc(authRepository: getIt(), sharedPreferencesHelper: getIt()));
  getIt.registerFactory<MapBloc>(() => MapBloc());
  getIt.registerFactory<CategoriesBloc>(
      () => CategoriesBloc(categoriesRepository: getIt()));
  getIt
      .registerFactory<SearchBloc>(() => SearchBloc(searchRepository: getIt()));
}
