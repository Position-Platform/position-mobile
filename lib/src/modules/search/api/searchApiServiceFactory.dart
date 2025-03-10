// ignore_for_file: avoid_print, file_names

import 'package:chopper/chopper.dart';
import 'package:position/src/core/services/apiService.dart';
import 'package:position/src/modules/search/api/searchApiService.dart';

class SearchApiServiceFactory implements SearchApiService {
  final ApiService? apiService;

  SearchApiServiceFactory(this.apiService);

  @override
  Future<Response> search(String query, int userId) async {
    Response response;

    try {
      response = await apiService!.search(query, userId);
    } catch (e) {
      print('Caught ${e.toString()}');
      rethrow;
    }
    return response;
  }
}
