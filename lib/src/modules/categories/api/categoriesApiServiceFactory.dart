// ignore_for_file: file_names

import 'dart:async';
import 'package:chopper/chopper.dart';
import 'package:position/src/core/services/apiService.dart';
import 'package:position/src/core/services/log.service.dart';
import 'package:position/src/modules/categories/api/categoriesApiService.dart';

class CategoriesApiServiceFactory implements CategoriesApiService {
  final ApiService? apiService;
  final LogService logger;

  // Cache temporaire pour les requêtes (debouncing)
  final Map<String, Completer<Response>> _pendingRequests = {};

  CategoriesApiServiceFactory(this.apiService, this.logger);

  @override
  Future<Response> getAllcategories() async {
    const requestKey = 'getAllCategories';

    // Si une requête identique est déjà en cours, attendre son résultat
    if (_pendingRequests.containsKey(requestKey)) {
      logger.info('Reusing pending request for all categories');
      return _pendingRequests[requestKey]!.future;
    }

    // Créer un nouveau Completer pour cette requête
    final completer = Completer<Response>();
    _pendingRequests[requestKey] = completer;

    try {
      logger.info('Requesting all categories');
      final response = await apiService!.getcategories();
      logger.info(
          'All categories response received, status: ${response.statusCode}');

      // Compléter la requête et la retirer de la liste des requêtes en attente
      completer.complete(response);
      _pendingRequests.remove(requestKey);

      return response;
    } catch (e) {
      logger.error('Error in getAllcategories: ${e.toString()}');

      // En cas d'erreur, compléter avec une erreur et nettoyer
      if (!completer.isCompleted) {
        completer.completeError(e);
      }
      _pendingRequests.remove(requestKey);

      rethrow;
    }
  }

  @override
  Future<Response> getCategorieById(int id) async {
    final requestKey = 'getCategoryById_$id';

    // Si une requête identique est déjà en cours, attendre son résultat
    if (_pendingRequests.containsKey(requestKey)) {
      logger.info('Reusing pending request for category ID: $id');
      return _pendingRequests[requestKey]!.future;
    }

    // Créer un nouveau Completer pour cette requête
    final completer = Completer<Response>();
    _pendingRequests[requestKey] = completer;

    try {
      logger.info('Requesting category with ID: $id');
      final response = await apiService!.getcategoriesbyid(id);
      logger.info('Category response received, status: ${response.statusCode}');

      // Compléter la requête et la retirer de la liste des requêtes en attente
      completer.complete(response);
      _pendingRequests.remove(requestKey);

      return response;
    } catch (e) {
      logger.error('Error in getCategorieById: ${e.toString()}');

      // En cas d'erreur, compléter avec une erreur et nettoyer
      if (!completer.isCompleted) {
        completer.completeError(e);
      }
      _pendingRequests.remove(requestKey);

      rethrow;
    }
  }

  @override
  Future<Response> updateCategorieById(
      String token, int id, Map<String, dynamic> body) async {
    try {
      logger.info('Updating category with ID: $id');
      final response = await apiService!.updatecategoriebyid(token, id, body);
      logger.info('Update category response: ${response.statusCode}');
      return response;
    } catch (e) {
      logger.error('Error in updateCategorieById: ${e.toString()}');
      rethrow;
    }
  }

  // Méthode pour annuler toutes les requêtes en cours (utile en cas de fermeture de l'app)
  void cancelAllRequests() {
    for (final request in _pendingRequests.values) {
      if (!request.isCompleted) {
        request.completeError('Request cancelled');
      }
    }
    _pendingRequests.clear();
  }
}
