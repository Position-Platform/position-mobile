// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart' as mapbox;
import 'package:position/src/core/services/log.service.dart';
import 'package:position/src/core/utils/configs.dart';
import 'package:position/src/modules/auth/models/setting_model/setting.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  mapbox.MapboxMap? _mapController;
  LogService logger;

  MapBloc({required this.logger}) : super(MapInitial()) {
    on<OnMapInitializedEvent>(_onInitMap);
    on<GetUserLocationEvent>(_getUserLocation);
    on<UserStyleSelectionEvent>(_userStyleSelection);
    on<RefreshMapEvent>((event, emit) {
      emit(MapInitial());
    });
  }

  void _onInitMap(OnMapInitializedEvent event, Emitter<MapState> emit) {
    _mapController = event.controller;
    _mapController?.logo.updateSettings(
        mapbox.LogoSettings(marginBottom: -100, marginLeft: -100));
    _mapController?.attribution.updateSettings(mapbox.AttributionSettings(
      clickable: false,
      marginBottom: -100,
      marginLeft: -100,
      position: mapbox.OrnamentPosition.BOTTOM_LEFT,
    ));
    _mapController?.compass
        .updateSettings(mapbox.CompassSettings(enabled: false));
    _mapController?.location.updateSettings(mapbox.LocationComponentSettings(
        enabled: true, puckBearingEnabled: true));
    _mapController?.scaleBar.updateSettings(mapbox.ScaleBarSettings(
      enabled: false,
    ));
    emit(MapInitialized());
  }

  void _getUserLocation(
      GetUserLocationEvent event, Emitter<MapState> emit) async {
    Position? position = await Geolocator.getLastKnownPosition();
    await _mapController?.flyTo(
        mapbox.CameraOptions(
            center: mapbox.Point(
                coordinates: mapbox.Position(
              position!.longitude,
              position.latitude,
            )),
            anchor: mapbox.ScreenCoordinate(
                x: position.latitude, y: position.longitude),
            zoom: initialMapZoom,
            bearing: 180,
            pitch: 30),
        mapbox.MapAnimationOptions(duration: 1000, startDelay: 0));
    // loguer la position de l'utilisateur
    logger.info("User location: ${position!.latitude}, ${position.longitude}");
    emit(MapGetUserLocation());
  }

  void _userStyleSelection(
      UserStyleSelectionEvent event, Emitter<MapState> emit) {
    _mapController?.loadStyleURI(event.style);
    // loguer le style de la carte selectionne
    logger.info("User selected style: ${event.style}");
    emit(MapStyleSelected(
      event.style,
    ));
  }
}
