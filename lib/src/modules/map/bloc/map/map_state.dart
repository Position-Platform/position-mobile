part of 'map_bloc.dart';

sealed class MapState extends Equatable {
  const MapState();

  @override
  List<Object> get props => [];
}

final class MapInitial extends MapState {}

final class MapInitialized extends MapState {}

final class MapGetUserLocation extends MapState {}

final class MapError extends MapState {}

final class MapStyleSelected extends MapState {
  final String style;

  const MapStyleSelected(this.style);

  @override
  List<Object> get props => [style];

  @override
  String toString() => 'MapStyleSelected { Style: $style }';
}
