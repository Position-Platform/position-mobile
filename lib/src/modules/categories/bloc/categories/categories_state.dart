part of 'categories_bloc.dart';

sealed class CategoriesState extends Equatable {
  const CategoriesState();

  @override
  List<Object> get props => [];
}

final class CategoriesInitial extends CategoriesState {}

final class CategoriesLoading extends CategoriesState {}

final class CategoriesError extends CategoriesState {
  final String message;

  const CategoriesError({this.message = 'An error occurred'});

  @override
  List<Object> get props => [message];

  @override
  String toString() => 'CategoriesError { Message: $message }';
}

final class CategoriesLoaded extends CategoriesState {
  final List<Category> categories;

  const CategoriesLoaded(this.categories);

  @override
  List<Object> get props => [categories];

  @override
  String toString() =>
      'CategoriesLoaded { Categories: ${categories.length} items }';
}

final class CategoriesClicked extends CategoriesState {
  final Category category;

  const CategoriesClicked(this.category);

  @override
  List<Object> get props => [category];

  @override
  String toString() =>
      'CategoriesClicked { Category: ${category.shortname} (ID: ${category.id}) }';
}

final class CategoryFound extends CategoriesState {
  final Category category;

  const CategoryFound(this.category);

  @override
  List<Object> get props => [category];

  @override
  String toString() =>
      'CategoryFound { Category: ${category.shortname} (ID: ${category.id}) }';
}
