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
  final LogService logger;

  // Ajouter des états pour conserver des informations et éviter les recalculs
  String? _currentStyle;
  Position? _lastPosition;

  MapBloc({required this.logger}) : super(MapInitial()) {
    on<OnMapInitializedEvent>(_onInitMap);
    on<GetUserLocationEvent>(_getUserLocation);
    on<UserStyleSelectionEvent>(_userStyleSelection);
    on<RefreshMapEvent>(_refreshMap);
  }

  void _onInitMap(OnMapInitializedEvent event, Emitter<MapState> emit) {
    _mapController = event.controller;

    // Configuration de la carte en une seule opération pour optimiser
    _configureMapSettings();

    // Définir le style initial si disponible dans les paramètres
    if (event.setting?.defaultMapStyle != null) {
      _currentStyle = event.setting!.defaultMapStyle;
    }

    emit(MapInitialized());
  }

  // Méthode extraite pour configurer tous les paramètres de la carte
  void _configureMapSettings() {
    if (_mapController == null) return;

    // Masquer le logo et autres éléments par défaut
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
  }

  Future<void> _getUserLocation(
      GetUserLocationEvent event, Emitter<MapState> emit) async {
    try {
      // Essayer d'obtenir la dernière position connue d'abord (plus rapide)
      _lastPosition = await Geolocator.getLastKnownPosition();

      final LocationSettings locationSettings = LocationSettings(
        accuracy: LocationAccuracy.high,
        timeLimit: const Duration(seconds: 5),
      );

      // Si pas de position, demander la position actuelle
      _lastPosition ??= await Geolocator.getCurrentPosition(
        locationSettings: locationSettings,
      );

      if (_lastPosition != null && _mapController != null) {
        await _flyToUserLocation(_lastPosition!);

        // Log de la position
        logger.info(
            "User location: ${_lastPosition!.latitude}, ${_lastPosition!.longitude}");

        emit(MapGetUserLocation());
      } else {
        emit(MapError());
      }
    } catch (e) {
      logger.error("Error getting user location: $e");
      emit(MapError());
    }
  }

  // Extraire la logique de déplacement de la caméra pour une meilleure lisibilité
  Future<void> _flyToUserLocation(Position position) async {
    if (_mapController == null) return;

    try {
      await _mapController?.flyTo(
          mapbox.CameraOptions(
              center: mapbox.Point(
                coordinates: mapbox.Position(
                  position.longitude,
                  position.latitude,
                ),
              ),
              anchor: mapbox.ScreenCoordinate(
                  x: position.latitude, y: position.longitude),
              zoom: initialMapZoom,
              bearing: 180,
              pitch: 30),
          mapbox.MapAnimationOptions(duration: 1000, startDelay: 0));
    } catch (e) {
      logger.error("Error flying to user location: $e");
    }
  }

  void _userStyleSelection(
      UserStyleSelectionEvent event, Emitter<MapState> emit) {
    try {
      // Stocker le style actuel pour pouvoir le réutiliser lors des refreshes
      _currentStyle = event.style;

      // Appliquer le style
      _mapController?.loadStyleURI(event.style);

      // Loguer le style de la carte sélectionné
      logger.info("User selected style: ${event.style}");

      emit(MapStyleSelected(event.style));
    } catch (e) {
      logger.error("Error setting map style: $e");
      emit(MapError());
    }
  }

  void _refreshMap(RefreshMapEvent event, Emitter<MapState> emit) async {
    // Optimisation : Si la carte n'est pas initialisée, rien à faire
    if (_mapController == null) {
      emit(MapInitial());
      return;
    }

    // Ré-appliquer le style actuel pour garantir un bon affichage
    if (_currentStyle != null) {
      try {
        await _mapController?.loadStyleURI(_currentStyle!);
      } catch (e) {
        logger.error("Error reloading style: $e");
      }
    }

    // Réinitialiser les paramètres de la carte
    _configureMapSettings();

    // Si une position utilisateur existe, recentrer la carte
    if (_lastPosition != null) {
      await _flyToUserLocation(_lastPosition!);
    }

    emit(MapInitial());
  }
}
