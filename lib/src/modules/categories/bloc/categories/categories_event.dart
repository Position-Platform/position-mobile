part of 'categories_bloc.dart';

sealed class CategoriesEvent extends Equatable {
  const CategoriesEvent();

  @override
  List<Object> get props => [];
}

class GetCategories extends CategoriesEvent {
  final bool forceRefresh;

  const GetCategories({this.forceRefresh = false});

  @override
  List<Object> get props => [forceRefresh];
}

class RefreshCategories extends CategoriesEvent {}

class CategorieClick extends CategoriesEvent {
  final Category? category;

  const CategorieClick(this.category);

  @override
  List<Object> get props => category != null ? [category!] : [];

  @override
  String toString() =>
      'CategorieClick { Category: ${category?.shortname} (ID: ${category?.id}) }';
}

class GetCategoryById extends CategoriesEvent {
  final int id;

  const GetCategoryById(this.id);

  @override
  List<Object> get props => [id];

  @override
  String toString() => 'GetCategoryById { ID: $id }';
}
