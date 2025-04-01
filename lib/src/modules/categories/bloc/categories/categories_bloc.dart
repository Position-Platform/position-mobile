// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:position/src/core/services/log.service.dart';
import 'package:position/src/modules/categories/models/categories_model/category.dart';
import 'package:position/src/modules/categories/repositories/categoriesRepository.dart';

part 'categories_event.dart';
part 'categories_state.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  CategoriesRepository categoriesRepository;
  LogService logger;
  CategoriesBloc({
    required this.categoriesRepository,
    required this.logger,
  }) : super(CategoriesInitial()) {
    on<GetCategories>(_getCategories);
    on<CategorieClick>(_selectCategorie);
  }

  _getCategories(GetCategories event, Emitter<CategoriesState> emit) async {
    emit(CategoriesLoading());
    try {
      // Log the request for all categories
      logger.info('Requesting all categories');
      var categoriesResult = await categoriesRepository.getallcategories();

      // Log the response from the API
      logger.info('All categories response: ${categoriesResult.success}');

      if (categoriesResult.success!.isNotEmpty) {
        categoriesResult.success!.sort((a, b) => b.vues!.compareTo(a.vues!));
        // Log the sorted categories
        logger.info('Sorted categories: ${categoriesResult.success}');
        emit(CategoriesLoaded(categoriesResult.success!));
      }
    } catch (e) {
      // Log the error
      logger.error('Caught error during get all categories: ${e.toString()}');
      emit(CategoriesError());
    }
  }

  _selectCategorie(CategorieClick event, Emitter<CategoriesState> emit) async {
    try {
      // Log the category click event
      logger.info('Category clicked: ${event.category}');
      emit(CategoriesClicked(event.category));
    } catch (e) {
      // Log the error
      logger.error('Caught error during category click: ${e.toString()}');
      emit(CategoriesError());
    }
  }
}
