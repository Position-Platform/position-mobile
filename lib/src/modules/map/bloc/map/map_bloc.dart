// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:maplibre_gl/maplibre_gl.dart';
import 'package:position/src/core/utils/configs.dart';
import 'package:position/src/modules/auth/models/setting_model/setting.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  MaplibreMapController? _mapController;

  MapBloc() : super(MapInitial()) {
    on<OnMapInitializedEvent>(_onInitMap);
    on<GetUserLocationEvent>(_getUserLocation);
  }

  void _onInitMap(OnMapInitializedEvent event, Emitter<MapState> emit) {
    _mapController = event.controller;
    emit(MapInitialized());
  }

  void _getUserLocation(
      GetUserLocationEvent event, Emitter<MapState> emit) async {
    Position position = await Geolocator.getCurrentPosition();
    _mapController?.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(position.latitude, position.longitude),
        zoom: initialMapZoom)));
    emit(MapGetUserLocation());
  }
}
