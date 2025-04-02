// ignore_for_file: file_names

import 'package:position/src/core/utils/result.dart';
import 'package:position/src/modules/categories/models/categories_model/category.dart';

abstract class CategoriesRepository {
  /// Récupère toutes les catégories
  /// [forceRefresh] si true, force une actualisation depuis le serveur
  Future<Result<List<Category>>> getallcategories({bool forceRefresh = false});

  /// Récupère une catégorie par son ID
  Future<Result<Category>> getcategoriebyid(int id);

  /// Effacer le cache local
  Future<void> clearCache();

  /// Vérifier si les données en cache sont fraîches (moins de X minutes)
  Future<bool> isCacheFresh();
}
