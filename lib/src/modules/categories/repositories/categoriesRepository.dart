// ignore_for_file: file_names

import 'package:position/src/core/utils/result.dart';
import 'package:position/src/modules/categories/models/categories_model/category.dart';

abstract class CategoriesRepository {
  Future<Result<List<Category>>> getallcategories();

  Future<Result<Category>> getcategoriebyid(int id);
}
