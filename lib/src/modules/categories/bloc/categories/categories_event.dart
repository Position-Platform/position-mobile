part of 'categories_bloc.dart';

sealed class CategoriesEvent extends Equatable {
  const CategoriesEvent();

  @override
  List<Object> get props => [];
}

class GetCategories extends CategoriesEvent {}

class CategorieClick extends CategoriesEvent {
  final Category? category;

  const CategorieClick(this.category);

  @override
  List<Object> get props => [category!];

  @override
  String toString() => 'CategorieClick { Category: $category }';
}
