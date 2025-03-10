// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:position/src/modules/categories/models/categories_model/category.dart';
import 'package:position/src/modules/categories/repositories/categoriesRepository.dart';

part 'categories_event.dart';
part 'categories_state.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  CategoriesRepository categoriesRepository;
  CategoriesBloc({
    required this.categoriesRepository,
  }) : super(CategoriesInitial()) {
    on<GetCategories>(_getCategories);
    on<CategorieClick>(_selectCategorie);
  }

  _getCategories(GetCategories event, Emitter<CategoriesState> emit) async {
    emit(CategoriesLoading());
    try {
      var categoriesResult = await categoriesRepository.getallcategories();

      if (categoriesResult.success!.isNotEmpty) {
        categoriesResult.success!.sort((a, b) => b.vues!.compareTo(a.vues!));
        emit(CategoriesLoaded(categoriesResult.success!));
      }
    } catch (e) {
      emit(CategoriesError());
    }
  }

  _selectCategorie(CategorieClick event, Emitter<CategoriesState> emit) async {
    try {
      emit(CategoriesClicked(event.category));
    } catch (e) {
      emit(CategoriesError());
    }
  }
}
