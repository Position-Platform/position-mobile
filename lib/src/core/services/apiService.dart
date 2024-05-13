// ignore_for_file: file_names

import 'package:chopper/chopper.dart';
import 'package:position/src/core/utils/configs.dart';

part 'apiService.chopper.dart';

@ChopperApi(baseUrl: apiUrl)
abstract class ApiService extends ChopperService {
  static ApiService create([ChopperClient? client]) => _$ApiService(client);

  //Settings
  @Get(path: '/api/settings', headers: {'Accept': 'application/json'})
  Future<Response> getAppSettings(@Header('Authorization') String token);
}
