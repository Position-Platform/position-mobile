// ignore_for_file: file_names, avoid_print

import 'package:chopper/chopper.dart';
import 'package:position/src/core/services/apiService.dart';
import 'package:position/src/core/services/log.service.dart';
import 'package:position/src/modules/categories/api/categoriesApiService.dart';

class CategoriesApiServiceFactory implements CategoriesApiService {
  final ApiService? apiService;
  final LogService logger;

  CategoriesApiServiceFactory(this.apiService, this.logger);

  @override
  Future<Response> getAllcategories() async {
    Response response;

    try {
      // Log the request for all categories
      logger.info('Requesting all categories');
      response = await apiService!.getcategories();
      // Log the response from the API
      logger.info('All categories response: ${response.body}');
    } catch (e) {
      // Log the error
      logger.error('Caught error during get all categories: ${e.toString()}');
      print('Caught ${e.toString()}');
      rethrow;
    }
    return response;
  }

  @override
  Future<Response> getCategorieById(int id) async {
    Response response;

    try {
      // Log the request for category by ID
      logger.info('Requesting category with ID: $id');
      response = await apiService!.getcategoriesbyid(id);
      // Log the response from the API
      logger.info('Category response: ${response.body}');
    } catch (e) {
      // Log the error
      logger.error('Caught error during get category by ID: ${e.toString()}');
      print('Caught ${e.toString()}');
      rethrow;
    }
    return response;
  }

  @override
  Future<Response> updateCategorieById(
      String token, int id, Map<String, dynamic> body) async {
    Response response;

    try {
      // Log the request for updating category by ID
      logger.info('Updating category with ID: $id with body: $body');
      response = await apiService!.updatecategoriebyid(token, id, body);
      // Log the response from the API
      logger.info('Update category response: ${response.body}');
    } catch (e) {
      // Log the error
      logger
          .error('Caught error during update category by ID: ${e.toString()}');
      print('Caught ${e.toString()}');
      rethrow;
    }
    return response;
  }
}
