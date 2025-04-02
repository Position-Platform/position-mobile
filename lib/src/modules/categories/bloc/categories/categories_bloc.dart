// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:position/src/core/services/log.service.dart';
import 'package:position/src/modules/categories/models/categories_model/category.dart';
import 'package:position/src/modules/categories/repositories/categoriesRepository.dart';

part 'categories_event.dart';
part 'categories_state.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  final CategoriesRepository categoriesRepository;
  final LogService logger;

  // Ajouter une mise en cache des catégories pour améliorer les performances
  List<Category> _cachedCategories = [];
  Category? selectedCategory;

  CategoriesBloc({
    required this.categoriesRepository,
    required this.logger,
  }) : super(CategoriesInitial()) {
    on<GetCategories>(_getCategories);
    on<CategorieClick>(_selectCategorie);
    on<GetCategoryById>(_getCategoryById);
    on<RefreshCategories>(_refreshCategories);
  }

  Future<void> _getCategories(
      GetCategories event, Emitter<CategoriesState> emit) async {
    // Si nous avons déjà les catégories en cache, les utiliser directement
    if (_cachedCategories.isNotEmpty && !event.forceRefresh) {
      logger
          .info('Using cached categories (${_cachedCategories.length} items)');
      emit(CategoriesLoaded(_cachedCategories));
      return;
    }

    emit(CategoriesLoading());
    try {
      logger.info('Requesting all categories');
      final categoriesResult = await categoriesRepository.getallcategories();

      if (categoriesResult.error != null) {
        logger.error('Error from repository: ${categoriesResult.error}');
        emit(CategoriesError(message: categoriesResult.error.toString()));
        return;
      }

      if (categoriesResult.success != null &&
          categoriesResult.success!.isNotEmpty) {
        // Trier par nombre de vues décroissant
        final sortedCategories = List<Category>.from(categoriesResult.success!)
          ..sort((a, b) => (b.vues ?? 0).compareTo(a.vues ?? 0));

        // Mettre en cache pour une utilisation future
        _cachedCategories = sortedCategories;

        logger.info('Loaded ${sortedCategories.length} categories');
        emit(CategoriesLoaded(sortedCategories));
      } else {
        logger.info('No categories found');
        emit(const CategoriesLoaded([]));
      }
    } catch (e) {
      logger.error('Exception during get all categories: ${e.toString()}');
      emit(CategoriesError(message: 'Failed to load categories'));
    }
  }

  Future<void> _refreshCategories(
      RefreshCategories event, Emitter<CategoriesState> emit) async {
    // Forcer une actualisation à partir du réseau
    add(const GetCategories(forceRefresh: true));
  }

  void _selectCategorie(CategorieClick event, Emitter<CategoriesState> emit) {
    try {
      if (event.category == null) {
        logger.info('Category click event received with null category');
        return;
      }

      selectedCategory = event.category;
      logger.info(
          'Category selected: ${event.category?.shortname} (ID: ${event.category?.id})');
      emit(CategoriesClicked(event.category!));
    } catch (e) {
      logger.error('Error during category click: ${e.toString()}');
      emit(CategoriesError(message: 'Failed to select category'));
    }
  }

  Future<void> _getCategoryById(
      GetCategoryById event, Emitter<CategoriesState> emit) async {
    emit(CategoriesLoading());

    try {
      // D'abord, vérifier si la catégorie est déjà en cache
      final cachedCategoryIndex =
          _cachedCategories.indexWhere((cat) => cat.id == event.id);

      if (cachedCategoryIndex >= 0) {
        // Catégorie trouvée dans le cache
        final cachedCategory = _cachedCategories[cachedCategoryIndex];
        logger.info(
            'Category found in cache: ${cachedCategory.shortname} (ID: ${cachedCategory.id})');
        emit(CategoryFound(cachedCategory));
        return;
      }

      // Si pas en cache, charger depuis le repository
      logger.info('Requesting category with ID: ${event.id}');
      final result = await categoriesRepository.getcategoriebyid(event.id);

      if (result.success != null) {
        logger.info('Category loaded: ${result.success?.shortname}');
        emit(CategoryFound(result.success!));
      } else {
        logger.error('Category not found with ID: ${event.id}');
        emit(CategoriesError(message: 'Category not found'));
      }
    } catch (e) {
      logger.error('Error fetching category by ID: ${e.toString()}');
      emit(CategoriesError(message: 'Failed to load category'));
    }
  }
}
