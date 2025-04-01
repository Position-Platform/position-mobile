// ignore_for_file: file_names, avoid_print

import 'package:chopper/chopper.dart';
import 'package:position/src/core/services/log.service.dart';
import 'package:position/src/modules/auth/api/setting/settingApiService.dart';
import 'package:position/src/core/services/apiService.dart';

class SettingApiServiceFactory implements SettingApiService {
  final ApiService? apiService;
  final LogService _logger = LogService();

  SettingApiServiceFactory(this.apiService);

  @override
  Future<Response> getappsettings() async {
    Response response;
    try {
      // Log the request for app settings
      _logger.info('Requesting app settings');
      response = await apiService!.getAppSettings();
      // Log the response from the API
      _logger.info('App settings response: ${response.body}');
    } catch (e) {
      // Log the error
      _logger.error('Caught error during get app settings: ${e.toString()}');
      print('Caught ${e.toString()}');
      rethrow;
    }
    return response;
  }
}
