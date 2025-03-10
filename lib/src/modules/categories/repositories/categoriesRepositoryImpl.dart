// ignore_for_file: file_names

import 'package:chopper/chopper.dart';
import 'package:drift/drift.dart';
import 'package:position/src/core/database/db.dart';
import 'package:position/src/core/helpers/network.dart';
import 'package:position/src/core/helpers/sharedpreferences.dart';
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

  CategoriesRepositoryImpl(
      {this.networkInfoHelper,
      this.categoriesApiService,
      this.sharedPreferencesHelper,
      this.categoryDao});

  @override
  Future<Result<List<Category>>> getallcategories() async {
    try {
      var localCategories = await categoryDao!.allCategories;

      if (localCategories.isNotEmpty) {
        return Result(
            success:
                localCategories.map((category) => category.category!).toList());
      }

      bool isConnected = await networkInfoHelper!.isConnected();
      if (isConnected) {
        try {
          final Response response =
              await categoriesApiService!.getAllcategories();
          var model = CategoriesModel.fromJson(response.body);

          await Future.wait(model.data!.categories!.map((onlineCategory) async {
            try {
              await categoryDao!.addCategory(CategoryTableCompanion(
                  id: Value(onlineCategory.id!),
                  category: Value(onlineCategory)));
            } catch (e) {
              return Result(error: DbInsertError());
            }
          }));

          return Result(success: model.data!.categories);
        } catch (e) {
          return Result(error: ServerError());
        }
      } else {
        return Result(error: NoInternetError());
      }
    } catch (e) {
      return Result(error: DbGetDataError());
    }
  }

  @override
  Future<Result<Category>> getcategoriebyid(int id) async {
    try {
      var categorie = await categoryDao!.getCategory(id);

      return Result(success: categorie.category!);
    } catch (e) {
      return Result(error: DbGetDataError());
    }
  }
}
