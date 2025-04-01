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

class _MapPageState extends State<MapPage> with WidgetsBindingObserver {
  late MapBloc _mapBloc;
  late AppBloc _appBloc;
  late CategoriesBloc _categoriesBloc;
  List<Category> categories = [];
  bool _isMapInitialized = false;

  @override
  void initState() {
    super.initState();
    _mapBloc = BlocProvider.of<MapBloc>(context);
    _categoriesBloc = BlocProvider.of<CategoriesBloc>(context);
    _appBloc = BlocProvider.of<AppBloc>(context);
    _categoriesBloc.add(GetCategories());

    // Observer pour détecter les changements d'orientation et de taille d'écran
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    // Réagir aux changements de taille d'écran (rotation, etc.)
    if (_isMapInitialized) {
      // Actualiser la carte si nécessaire
      _mapBloc.add(RefreshMapEvent());
    }
    super.didChangeMetrics();
  }

  void _handleMapInitialized(MapboxMap controller) {
    _isMapInitialized = true;
    _mapBloc.add(OnMapInitializedEvent(controller, widget.setting));
  }

  void _handleCategoryClick(Category category) {
    _categoriesBloc.add(CategorieClick(category));
  }

  void _handleStyleSelection() {
    showModalBottomSheet(
      context: context,
      isScrollControlled:
          true, // Pour un meilleur comportement sur les petits écrans
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (BuildContext context) {
        return PositionStyleSelection(
          onStyleSelected: (style) {
            _mapBloc.add(UserStyleSelectionEvent(style));
          },
        );
      },
    );
  }

  Future<void> _openSearch() async {
    await showSearch(
      context: context,
      delegate: PositionMapSearchDelegate(
        hintText: PositionLocalizations.of(context).hintSearch,
        searchBloc: BlocProvider.of<SearchBloc>(context),
        user: widget.user,
      ),
    ).then((value) {
      if (value != null) {
        // Traiter le résultat de recherche ici
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isLandscape = screenSize.width > screenSize.height;
    final bottomPadding = MediaQuery.of(context).padding.bottom;

    changeStatusColor(transparent);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: MultiBlocListener(
        listeners: [
          BlocListener<MapBloc, MapState>(
            listener: (context, state) {
              if (state is MapInitialized) {
                _mapBloc.add(GetUserLocationEvent());
              }
              if (state is MapStyleSelected) {
                if (state.style == MapboxStyles.DARK) {
                  _appBloc.add(const ChangeTheme(AppTheme.darkTheme));
                } else {
                  _appBloc.add(const ChangeTheme(AppTheme.lightTheme));
                }
              }
            },
          ),
          BlocListener<CategoriesBloc, CategoriesState>(
            listener: (context, state) {
              if (state is CategoriesLoaded) {
                setState(() {
                  categories = state.categories!;
                });
              }
            },
          ),
        ],
        child: BlocBuilder<MapBloc, MapState>(
          builder: (context, mapState) {
            MapboxOptions.setAccessToken(widget.setting.mapApiKey!);
            return Stack(
              children: [
                // Carte MapBox
                MapWidget(
                  key: const ValueKey("mapWidget"),
                  cameraOptions: CameraOptions(
                    center: Point(
                      coordinates: Position(0, 0),
                    ),
                    zoom: 2, // Zoom par défaut ajouté
                  ),
                  styleUri: _appBloc.state.themeData ==
                          AppThemes.appThemeData[AppTheme.darkTheme]
                      ? MapboxStyles.DARK
                      : widget.setting.defaultMapStyle!,
                  textureView: true,
                  onMapCreated: _handleMapInitialized,
                  onStyleLoadedListener: (styleLoadedEventData) {
                    // Traitement supplémentaire lorsque le style est chargé
                  },
                  onLongTapListener: (coordinate) {
                    // Gestion du tap long
                  },
                  onTapListener: (coordinate) {
                    // Gestion du tap
                  },
                ),

                // Interface utilisateur superposée à la carte
                SafeArea(
                  child: Column(
                    children: [
                      // Barre de recherche
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 8.0),
                        child: PositionSearchBar(
                          openDrawer: () {
                            // Ouvrir le tiroir de navigation
                          },
                          openSearch: _openSearch,
                          labelSearch: PositionLocalizations.of(context).search,
                          openProfile: () {
                            // Ouvrir le profil
                          },
                        ),
                      ),

                      // Widget des catégories
                      Container(
                        height: isLandscape
                            ? 50
                            : 50, // Ajustement pour le mode paysage
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: PositionCategoriesWidget(
                          categories: categories,
                          categoryClick: _handleCategoryClick,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),

      // Boutons flottants
      floatingActionButton: Padding(
        padding: EdgeInsets.only(bottom: bottomPadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const Spacer(),
            PositionMapFloatongActionButton(
              buttonTag: "layers",
              buttonPressed: _handleStyleSelection,
              buttonIcon: const Icon(
                Icons.layers,
                color: primaryColor,
              ),
            ),
            const SizedBox(height: 10),
            PositionMapFloatongActionButton(
              buttonTag: "location",
              buttonPressed: () {
                _mapBloc.add(GetUserLocationEvent());
              },
              buttonIcon: SvgPicture.asset(
                "assets/images/svg/icon-my_location.svg",
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
