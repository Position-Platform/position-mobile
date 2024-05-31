// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:position/generated/l10n.dart';
import 'package:position/src/core/utils/colors.dart';
import 'package:position/src/core/utils/configs.dart';
import 'package:position/src/core/utils/tools.dart';
import 'package:position/src/modules/auth/models/setting_model/setting.dart';
import 'package:position/src/modules/categories/bloc/categories/categories_bloc.dart';
import 'package:position/src/modules/categories/models/categories_model/category.dart';
import 'package:position/src/modules/map/bloc/map/map_bloc.dart';
import 'package:position/src/modules/map/widgets/positionCategoriesWidget.dart';
import 'package:position/src/modules/map/widgets/positionSearchBar.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key, required this.setting});
  final Setting setting;

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  MapBloc? _mapBloc;
  CategoriesBloc? _categoriesBloc;
  List<Category> categories = [];

  @override
  void initState() {
    super.initState();
    _mapBloc = BlocProvider.of<MapBloc>(context);
    _categoriesBloc = BlocProvider.of<CategoriesBloc>(context);
    _categoriesBloc?.add(GetCategories());
  }

  @override
  Widget build(BuildContext context) {
    changeStatusColor(transparent);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: MultiBlocListener(
        listeners: [
          BlocListener<MapBloc, MapState>(
            listener: (context, state) {
              if (state is MapInitialized) {
                _mapBloc?.add(GetUserLocationEvent());
              }
            },
          ),
          BlocListener<CategoriesBloc, CategoriesState>(
            listener: (context, state) {
              if (state is CategoriesLoading) {}
              if (state is CategoriesLoaded) {
                categories = state.categories!;
              }
            },
          ),
        ],
        child: BlocBuilder<MapBloc, MapState>(
          builder: (context, state) {
            MapboxOptions.setAccessToken(mapboxKey!);
            return Stack(
              children: [
                MapWidget(
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
                ),
                SafeArea(
                    child: Column(
                  children: [
                    PositionSearchBar(
                      openDrawer: () {},
                      openSearch: () {},
                      labelSearch: PositionLocalizations.of(context).search,
                      openProfile: () {},
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    PositionCategoriesWidget(categories: categories)
                  ],
                )),
              ],
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
