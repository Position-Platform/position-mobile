// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:position/generated/l10n.dart';
import 'package:position/src/core/utils/colors.dart';
import 'package:position/src/core/utils/themes.dart';
import 'package:position/src/core/utils/tools.dart';
import 'package:position/src/modules/app/bloc/app_bloc.dart';
import 'package:position/src/modules/auth/models/setting_model/setting.dart';
import 'package:position/src/modules/auth/models/user_model/user.dart';
import 'package:position/src/modules/categories/bloc/categories/categories_bloc.dart';
import 'package:position/src/modules/categories/models/categories_model/category.dart';
import 'package:position/src/modules/map/bloc/map/map_bloc.dart';
import 'package:position/src/modules/map/widgets/positionCategoriesWidget.dart';
import 'package:position/src/modules/map/widgets/positionMapFloatongActionButton.dart';
import 'package:position/src/modules/map/widgets/positionSearchBar.dart';
import 'package:position/src/modules/map/widgets/positionStyleSelection.dart';
import 'package:position/src/modules/search/bloc/bloc/search_bloc.dart';
import 'package:position/src/modules/search/views/positionMapSearchDelegate.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key, required this.setting, required this.user});
  final Setting setting;
  final User user;

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  MapBloc? _mapBloc;
  AppBloc? _appBloc;
  CategoriesBloc? _categoriesBloc;
  List<Category> categories = [];

  @override
  void initState() {
    super.initState();
    _mapBloc = BlocProvider.of<MapBloc>(context);
    _categoriesBloc = BlocProvider.of<CategoriesBloc>(context);
    _appBloc = BlocProvider.of<AppBloc>(context);
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
              if (state is MapStyleSelected) {
                if (state.style == MapboxStyles.DARK) {
                  _appBloc!.add(const ChangeTheme(AppTheme.darkTheme));
                } else {
                  _appBloc!.add(const ChangeTheme(AppTheme.lightTheme));
                }
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
            MapboxOptions.setAccessToken(widget.setting.mapApiKey!);
            return BlocBuilder<CategoriesBloc, CategoriesState>(
              builder: (context, state) {
                return Stack(
                  children: [
                    MapWidget(
                      key: const ValueKey("mapWidget"),
                      cameraOptions: CameraOptions(
                        center: Point(
                            coordinates: Position(
                          0,
                          0,
                        )),
                      ),
                      styleUri: _appBloc?.state.themeData ==
                              AppThemes.appThemeData[AppTheme.darkTheme]
                          ? MapboxStyles.DARK
                          : widget.setting.defaultMapStyle!,
                      textureView: true,
                      onMapCreated: (controller) => _mapBloc?.add(
                          OnMapInitializedEvent(controller, widget.setting)),
                      onStyleLoadedListener: (styleLoadedEventData) {},
                      onLongTapListener: (coordinate) {},
                      onTapListener: (coordinate) {},
                    ),
                    SafeArea(
                        child: Column(
                      children: [
                        PositionSearchBar(
                          openDrawer: () {},
                          openSearch: () async {
                            await showSearch(
                                    context: context,
                                    delegate: PositionMapSearchDelegate(
                                        hintText:
                                            PositionLocalizations.of(context)
                                                .hintSearch,
                                        searchBloc: BlocProvider.of<SearchBloc>(
                                            context),
                                        user: widget.user))
                                .then((value) {
                              if (value != null) {}
                            });
                          },
                          labelSearch: PositionLocalizations.of(context).search,
                          openProfile: () {},
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        PositionCategoriesWidget(
                            categories: categories,
                            categoryClick: (category) {
                              _categoriesBloc?.add(CategorieClick(category));
                            }),
                      ],
                    )),
                  ],
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: Align(
        alignment: Alignment.bottomRight,
        child: Wrap(
          direction: Axis.vertical,
          children: [
            PositionMapFloatongActionButton(
                buttonTag: "layers",
                buttonPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return PositionStyleSelection(
                        onStyleSelected: (style) {
                          _mapBloc?.add(UserStyleSelectionEvent(style));
                        },
                      );
                    },
                  );
                },
                buttonIcon: const Icon(
                  Icons.layers,
                  color: primaryColor,
                )),
            const SizedBox(
              height: 10,
            ),
            PositionMapFloatongActionButton(
                buttonTag: "location",
                buttonPressed: () {
                  _mapBloc?.add(GetUserLocationEvent());
                },
                buttonIcon: SvgPicture.asset(
                  "assets/images/svg/icon-my_location.svg",
                )),
          ],
        ),
      ),
    );
  }
}
