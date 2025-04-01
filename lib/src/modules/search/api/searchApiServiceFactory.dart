// ignore_for_file: avoid_print, file_names

import 'package:chopper/chopper.dart';
import 'package:position/src/core/services/apiService.dart';
import 'package:position/src/core/services/log.service.dart';
import 'package:position/src/modules/search/api/searchApiService.dart';

class SearchApiServiceFactory implements SearchApiService {
  final ApiService? apiService;
  final LogService logger;

  SearchApiServiceFactory(this.apiService, this.logger);

  @override
  Future<Response> search(String query, int userId) async {
    Response response;

    try {
      // Log the search query and user ID
      logger.info('Search request with query: $query and user ID: $userId');
      response = await apiService!.search(query, userId);
      // Log the response from the API
      logger.info('Search response: ${response.body}');
    } catch (e) {
      // Log the error
      logger.error('Caught error during search: ${e.toString()}');
      print('Caught ${e.toString()}');
      rethrow;
    }
    return response;
  }
}
