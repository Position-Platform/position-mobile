// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
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
          if (state is MapInitialized) {
            _mapBloc?.add(GetUserLocationEvent());
          }
        },
        child: BlocBuilder<MapBloc, MapState>(
          builder: (context, state) {
            MapboxOptions.setAccessToken(mapboxKey!);
            return MapWidget(
              key: const ValueKey("mapWidget"),
              cameraOptions: CameraOptions(
                center: Point(
                    coordinates: Position(
                  0,
                  0,
                )).toJson(),
              ),
              styleUri: MapboxStyles.MAPBOX_STREETS,
              textureView: true,
              onMapCreated: (controller) => _mapBloc
                  ?.add(OnMapInitializedEvent(controller, widget.setting)),
              onStyleLoadedListener: (styleLoadedEventData) {},
              onLongTapListener: (coordinate) {},
              onTapListener: (coordinate) {},
            );
          },
        ),
      ),
      floatingActionButton: Align(
        alignment: Alignment.bottomRight,
        child: Wrap(
          direction: Axis.vertical,
          children: [
            SizedBox(
              width: 50,
              height: 50,
              child: FittedBox(
                child: FloatingActionButton(
                  shape: const CircleBorder(),
                  heroTag: "location",
                  tooltip: "Location",
                  backgroundColor: Theme.of(context).colorScheme.background,
                  onPressed: () {
                    _mapBloc?.add(GetUserLocationEvent());
                  },
                  child: SvgPicture.asset(
                    "assets/images/svg/icon-my_location.svg",
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
