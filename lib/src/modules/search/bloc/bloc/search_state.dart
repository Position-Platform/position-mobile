part of 'search_bloc.dart';

sealed class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

final class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchLoaded extends SearchState {
  final List<SearchResultModel>? searchresult;

  const SearchLoaded(this.searchresult);

  @override
  List<Object> get props => [searchresult!];

  @override
  String toString() => 'SearchLoaded { Search Result: $searchresult }';
}

class SearchError extends SearchState {}
