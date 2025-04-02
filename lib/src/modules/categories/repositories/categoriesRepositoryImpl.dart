// ignore_for_file: file_names

import 'package:chopper/chopper.dart';
import 'package:drift/drift.dart';
import 'package:position/src/core/database/db.dart';
import 'package:position/src/core/helpers/network.dart';
import 'package:position/src/core/helpers/sharedpreferences.dart';
import 'package:position/src/core/services/log.service.dart';
import 'package:position/src/core/utils/result.dart';
import 'package:position/src/modules/categories/api/categoriesApiService.dart';
import 'package:position/src/modules/categories/db/category.dao.dart';
import 'package:position/src/modules/categories/models/categories_model/categories_model.dart';
import 'package:position/src/modules/categories/models/categories_model/category.dart';
import 'package:position/src/modules/categories/repositories/categoriesRepository.dart';

class CategoriesRepositoryImpl implements CategoriesRepository {
  final NetworkInfoHelper? networkInfoHelper;
  final CategoriesApiService? categoriesApiService;
  final SharedPreferencesHelper? sharedPreferencesHelper;
  final CategoryDao? categoryDao;
  final LogService logger;

  // Constantes pour la gestion du cache
  static const String _lastCacheTimeKey = 'categories_last_cache_time';
  static const int _cacheValidityMinutes =
      30; // Le cache est valide pendant 30 minutes

  CategoriesRepositoryImpl(
      {required this.networkInfoHelper,
      required this.categoriesApiService,
      required this.sharedPreferencesHelper,
      required this.categoryDao,
      required this.logger});

  @override
  Future<Result<List<Category>>> getallcategories(
      {bool forceRefresh = false}) async {
    try {
      // Vérifier si nous devons forcer une actualisation ou si le cache est obsolète
      final shouldRefresh = forceRefresh || !(await isCacheFresh());

      // Si nous n'avons pas besoin de rafraîchir et que nous avons des données locales, les utiliser
      if (!shouldRefresh) {
        final localCategories = await categoryDao!.allCategories;
        if (localCategories.isNotEmpty) {
          logger.info(
              "Using cached categories (${localCategories.length} items)");
          final categories =
              localCategories.map((cat) => cat.category!).toList();
          return Result(success: categories);
        }
      }

      // Si pas de données locales ou si on doit rafraîchir, aller sur le réseau
      final isConnected = await networkInfoHelper!.isConnected();
      if (isConnected) {
        return await _fetchCategoriesFromNetwork();
      } else {
        // En cas d'absence de connexion, essayer d'utiliser les données locales même si obsolètes
        final localCategories = await categoryDao!.allCategories;
        if (localCategories.isNotEmpty) {
          logger.info(
              "No internet connection. Using potentially outdated local data.");
          final categories =
              localCategories.map((cat) => cat.category!).toList();
          return Result(success: categories);
        }

        logger.error("No internet connection and no local cache available.");
        return Result(error: NoInternetError());
      }
    } catch (e) {
      logger.error("Error in getallcategories: $e");
      return Result(error: ServerError());
    }
  }

  /// Récupère les catégories depuis le réseau et les met en cache
  Future<Result<List<Category>>> _fetchCategoriesFromNetwork() async {
    try {
      logger.info("Fetching categories from network");
      final Response response = await categoriesApiService!.getAllcategories();

      if (response.isSuccessful) {
        final model = CategoriesModel.fromJson(response.body);

        if (model.data?.categories != null &&
            model.data!.categories!.isNotEmpty) {
          await _cacheCategories(model.data!.categories!);
          return Result(success: model.data!.categories);
        } else {
          logger.info("API returned empty categories list");
          return Result(success: []);
        }
      } else {
        logger.error("API error: ${response.statusCode} - ${response.error}");
        return Result(error: ServerError());
      }
    } catch (e) {
      logger.error("Network error in _fetchCategoriesFromNetwork: $e");
      return Result(error: ServerError());
    }
  }

  /// Met en cache les catégories dans la base de données locale
  Future<void> _cacheCategories(List<Category> categories) async {
    try {
      logger.info("Caching ${categories.length} categories");

      // Utiliser une transaction pour améliorer les performances
      await categoryDao!.db.transaction(() async {
        for (final category in categories) {
          if (category.id != null) {
            await categoryDao!.addCategory(CategoryTableCompanion(
              id: Value(category.id!),
              category: Value(category),
            ));
          }
        }
      });

      // Enregistrer la date de mise en cache
      await sharedPreferencesHelper!
          .setCategoriesLastCacheTime(DateTime.now().millisecondsSinceEpoch);

      logger.info("Categories cached successfully");
    } catch (e) {
      logger.error("Error caching categories: $e");
      throw DbInsertError();
    }
  }

  @override
  Future<Result<Category>> getcategoriebyid(int id) async {
    try {
      logger.info("Getting category with ID: $id");

      try {
        // Tenter de récupérer depuis la base de données locale
        final category = await categoryDao!.getCategory(id);
        logger.info(
            "Found category in local cache: ${category.category?.shortname}");
        return Result(success: category.category!);
      } catch (dbError) {
        logger.error("Category not found in local cache: $dbError");

        // Si pas trouvé localement et connexion disponible, essayer depuis le réseau
        final isConnected = await networkInfoHelper!.isConnected();
        if (isConnected) {
          logger.info("Fetching category from network");
          final response = await categoriesApiService!.getCategorieById(id);

          if (response.isSuccessful) {
            final categoryModel = CategoriesModel.fromJson(response.body);
            if (categoryModel.data?.categories != null &&
                categoryModel.data!.categories!.isNotEmpty) {
              final category = categoryModel.data!.categories!.first;

              // Mettre en cache la catégorie récupérée
              await categoryDao!.addCategory(CategoryTableCompanion(
                id: Value(category.id!),
                category: Value(category),
              ));

              return Result(success: category);
            }
          }

          logger.error("Category not found on server");
          return Result(error: ServerError());
        } else {
          logger.error("No internet connection for fetching category");
          return Result(error: NoInternetError());
        }
      }
    } catch (e) {
      logger.error("Error in getcategoriebyid: $e");
      return Result(error: ServerError());
    }
  }

  @override
  Future<void> clearCache() async {
    try {
      logger.info("Clearing categories cache");
      await categoryDao!.deleteAllCategories();
      await sharedPreferencesHelper!.removeKey(_lastCacheTimeKey);
      logger.info("Categories cache cleared successfully");
    } catch (e) {
      logger.error("Error clearing categories cache: $e");
      throw DbDeleteError();
    }
  }

  @override
  Future<bool> isCacheFresh() async {
    try {
      final lastCacheTime =
          await sharedPreferencesHelper!.getCategoriesLastCacheTime();
      if (lastCacheTime == null) return false;

      final cacheAge = DateTime.now().millisecondsSinceEpoch - lastCacheTime;
      final cacheAgeMinutes = cacheAge ~/ (1000 * 60);

      logger.info(
          "Cache age: $cacheAgeMinutes minutes (validity: $_cacheValidityMinutes minutes)");
      return cacheAgeMinutes < _cacheValidityMinutes;
    } catch (e) {
      logger.error("Error checking cache freshness: $e");
      return false;
    }
  }
}
