part of 'search_bloc.dart';

sealed class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class MakeSearch extends SearchEvent {
  final String? query;
  final User? user;

  const MakeSearch(this.query, this.user);

  @override
  List<Object> get props => [query!];

  @override
  String toString() => 'MakeSearch { Query: $query }';
}
