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
  late final MapBloc _mapBloc;
  late final AppBloc _appBloc;
  late final CategoriesBloc _categoriesBloc;
  List<Category> _categories = [];
  bool _isMapInitialized = false;

  // Cache des widgets constants pour éviter les reconstructions
  late final SvgPicture _locationIcon = SvgPicture.asset(
    "assets/images/svg/icon-my_location.svg",
    height: 24,
    width: 24,
  );

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
    // Réagir aux changements de taille d'écran uniquement si la carte est initialisée
    if (_isMapInitialized) {
      // Utiliser un délai pour éviter des actualisations trop fréquentes pendant le redimensionnement
      Future.delayed(const Duration(milliseconds: 300), () {
        if (mounted) {
          _mapBloc.add(RefreshMapEvent());
        }
      });
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
      isScrollControlled: true,
      backgroundColor: Theme.of(context).colorScheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => PositionStyleSelection(
        onStyleSelected: (style) {
          _mapBloc.add(UserStyleSelectionEvent(style));
        },
      ),
    );
  }

  Future<void> _openSearch() async {
    final result = await showSearch(
      context: context,
      delegate: PositionMapSearchDelegate(
        hintText: PositionLocalizations.of(context).hintSearch,
        searchBloc: BlocProvider.of<SearchBloc>(context),
        user: widget.user,
      ),
    );

    if (result != null && mounted) {
      // Traiter le résultat de recherche ici
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isLandscape = screenSize.width > screenSize.height;
    final bottomPadding = MediaQuery.of(context).viewPadding.bottom;

    changeStatusColor(transparent);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: MultiBlocListener(
        listeners: [
          BlocListener<MapBloc, MapState>(
            listener: (context, state) {
              if (state is MapInitialized) {
                _mapBloc.add(GetUserLocationEvent());
              } else if (state is MapStyleSelected) {
                final newTheme = state.style == MapboxStyles.DARK
                    ? const ChangeTheme(AppTheme.darkTheme)
                    : const ChangeTheme(AppTheme.lightTheme);
                _appBloc.add(newTheme);
              }
            },
          ),
          BlocListener<CategoriesBloc, CategoriesState>(
            listener: (context, state) {
              if (state is CategoriesLoaded) {
                setState(() {
                  _categories = state.categories;
                });
              }
            },
          ),
        ],
        child: BlocBuilder<MapBloc, MapState>(
          buildWhen: (previous, current) {
            // Reconstruire uniquement lors de changements d'état pertinents
            return current is MapInitial || current is MapStyleSelected;
          },
          builder: (context, mapState) {
            MapboxOptions.setAccessToken(widget.setting.mapApiKey!);

            final isDarkTheme = _appBloc.state.themeData ==
                AppThemes.appThemeData[AppTheme.darkTheme];

            final String mapStyle = isDarkTheme
                ? MapboxStyles.DARK
                : widget.setting.defaultMapStyle!;

            return Stack(
              children: [
                // Carte MapBox
                MapWidget(
                  key: const ValueKey("mapWidget"),
                  cameraOptions: CameraOptions(
                    center: Point(coordinates: Position(0, 0)),
                    zoom: 2,
                  ),
                  styleUri: mapStyle,
                  textureView: true,
                  onMapCreated: _handleMapInitialized,
                  onStyleLoadedListener: (_) {}, // Simplifié
                  onLongTapListener: (_) {}, // Simplifié
                  onTapListener: (_) {}, // Simplifié
                ),

                // Interface utilisateur
                _buildUILayer(isLandscape),
              ],
            );
          },
        ),
      ),

      // Boutons flottants
      floatingActionButton: _buildFloatingButtons(bottomPadding),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  // Extrait en méthode pour plus de clarté
  Widget _buildUILayer(bool isLandscape) {
    return SafeArea(
      child: Column(
        children: [
          // Barre de recherche
          Padding(
            padding: const EdgeInsets.all(8.0),
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
          SizedBox(
            height: 40,
            child: PositionCategoriesWidget(
              categories: _categories,
              categoryClick: _handleCategoryClick,
            ),
          ),
        ],
      ),
    );
  }

  // Extrait en méthode pour plus de clarté
  Widget _buildFloatingButtons(double bottomPadding) {
    return Padding(
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
              size: 24,
            ),
          ),
          const SizedBox(height: 10),
          PositionMapFloatongActionButton(
            buttonTag: "location",
            buttonPressed: () => _mapBloc.add(GetUserLocationEvent()),
            buttonIcon: _locationIcon,
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
