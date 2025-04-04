part of 'map_bloc.dart';

sealed class MapEvent extends Equatable {
  const MapEvent();

  @override
  List<Object> get props => [];
}

class OnMapInitializedEvent extends MapEvent {
  final mapbox.MapboxMap controller;
  final Setting? setting;

  const OnMapInitializedEvent(this.controller, this.setting);
}

class GetUserLocationEvent extends MapEvent {}

class UserStyleSelectionEvent extends MapEvent {
  final String style;

  const UserStyleSelectionEvent(this.style);
}

class RefreshMapEvent extends MapEvent {}
