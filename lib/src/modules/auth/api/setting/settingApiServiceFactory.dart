// ignore_for_file: file_names, avoid_print

import 'package:chopper/chopper.dart';
import 'package:position/src/modules/auth/api/setting/settingApiService.dart';
import 'package:position/src/core/services/apiService.dart';

class SettingApiServiceFactory implements SettingApiService {
  final ApiService? apiService;

  SettingApiServiceFactory(this.apiService);

  @override
  Future<Response> getappsettings() async {
    Response response;
    try {
      response = await apiService!.getAppSettings();
    } catch (e) {
      print('Caught ${e.toString()}');
      rethrow;
    }
    return response;
  }
}
