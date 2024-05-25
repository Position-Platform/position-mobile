// ignore_for_file: file_names

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maplibre_gl/maplibre_gl.dart';
import 'package:position/src/core/utils/colors.dart';
import 'package:position/src/core/utils/configs.dart';
import 'package:position/src/core/utils/tools.dart';
import 'package:position/src/modules/auth/models/setting_model/setting.dart';
import 'package:position/src/modules/map/bloc/map/map_bloc.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key, required this.setting});
  final Setting setting;

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  MapBloc? _mapBloc;

  @override
  void initState() {
    super.initState();
    _mapBloc = BlocProvider.of<MapBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    changeStatusColor(transparent);
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: BlocListener<MapBloc, MapState>(
          listener: (context, state) {
            if (state is MapInitialized) {}
          },
          child: BlocBuilder<MapBloc, MapState>(
            builder: (context, state) {
              return MaplibreMap(
                attributionButtonPosition: AttributionButtonPosition.BottomLeft,
                attributionButtonMargins: const Point(-100, -100),
                rotateGesturesEnabled: false,
                annotationOrder: const [AnnotationType.symbol],
                compassViewPosition: CompassViewPosition.BottomLeft,
                zoomGesturesEnabled: true,
                myLocationEnabled: true,
                myLocationTrackingMode: MyLocationTrackingMode.Tracking,
                myLocationRenderMode: MyLocationRenderMode.GPS,
                compassEnabled: true,
                onMapClick: (point, coordinates) => () {},
                styleString:
                    "${widget.setting.defaultMapStyle}?key=${widget.setting.mapApiKey}",
                onMapLongClick: (point, latLng) => () {},
                onMapCreated: (controller) => _mapBloc
                    ?.add(OnMapInitializedEvent(controller, widget.setting)),
                doubleClickZoomEnabled: true,
                initialCameraPosition: const CameraPosition(
                    zoom: initialMapZoom, target: LatLng(0, 0)),
                onStyleLoadedCallback: () {},
              );
            },
          ),
        ));
  }
}
