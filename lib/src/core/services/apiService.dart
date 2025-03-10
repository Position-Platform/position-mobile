// ignore_for_file: file_names

import 'package:chopper/chopper.dart';
import 'package:position/src/core/utils/configs.dart';

part 'apiService.chopper.dart';

@ChopperApi(baseUrl: apiUrl)
abstract class ApiService extends ChopperService {
  static ApiService create([ChopperClient? client]) => _$ApiService(client);

  //Settings
  @GET(path: '/api/settings', headers: {'Accept': 'application/json'})
  Future<Response> getAppSettings();

  // User Api
  @POST(path: '/api/auth/login', headers: {'Accept': 'application/json'})
  Future<Response> login(@Body() Map<String, dynamic> body);

  @POST(path: '/api/auth/register', headers: {'Accept': 'application/json'})
  Future<Response> register(@Body() Map<String, dynamic> body);

  @POST(
      path: '/api/auth/register/facebook',
      headers: {'Accept': 'application/json'})
  Future<Response> registerfacebook(@Body() Map<String, dynamic> body);

  @POST(
      path: '/api/auth/register/google',
      headers: {'Accept': 'application/json'})
  Future<Response> registergoogle(@Body() Map<String, dynamic> body);

  @POST(
      path: '/api/auth/register/apple', headers: {'Accept': 'application/json'})
  Future<Response> registerapple(@Body() Map<String, dynamic> body);

  @GET(path: '/api/user/me', headers: {'Accept': 'application/json'})
  Future<Response> getuser(
    @Header('Authorization') String token,
  );

  @POST(
      path: '/api/auth/password/forgot',
      headers: {'Accept': 'application/json'})
  Future<Response> forgetPassword(@Body() Map<String, dynamic> body);

  @POST(
      path: '/api/auth/password/reset', headers: {'Accept': 'application/json'})
  Future<Response> resetPassword(@Body() Map<String, dynamic> body);

  @GET(path: '/api/auth/logout', headers: {'Accept': 'application/json'})
  Future<Response> logout(
    @Header('Authorization') String token,
  );

// Categories
  @GET(path: '/api/categories', headers: {'Accept': 'application/json'})
  Future<Response> getcategories();

  @GET(path: '/api/categories/{id}', headers: {'Accept': 'application/json'})
  Future<Response> getcategoriesbyid(@Path('id') int idCategorie);

  @PUT(path: '/api/categories/{id}', headers: {'Accept': 'application/json'})
  Future<Response> updatecategoriebyid(@Header('Authorization') String token,
      @Path('id') int idCategorie, @Body() Map<String, dynamic> body);

  //Search
  @GET(
      path: '/api/search/etablissements',
      headers: {'Accept': 'application/json'})
  Future<Response> search(
    @Query('q') String query,
    @Query('user_id') int userId,
  );
}
