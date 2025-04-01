// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:position/src/core/utils/colors.dart';

class PositionStyleSelection extends StatelessWidget {
  const PositionStyleSelection({
    super.key,
    required this.onStyleSelected,
  });

  final Function(String style) onStyleSelected;

  // Déplacer les styles en constante de classe pour éviter de les recréer à chaque build
  static const List<Map<String, dynamic>> _mapStyles = [
    {
      'name': 'GeOsm',
      'image': 'assets/images/png/geosm.png',
      'style': 'mapbox://styles/gauty96/cl5r7guxo000216qracix6p8t'
    },
    {
      'name': 'Street',
      'image': 'assets/images/png/street.png',
      'style': MapboxStyles.MAPBOX_STREETS
    },
    {
      'name': 'Satellite Street',
      'image': 'assets/images/png/satellite.png',
      'style': MapboxStyles.SATELLITE_STREETS
    },
    {
      'name': 'Dark',
      'image': 'assets/images/png/dark.png',
      'style': MapboxStyles.DARK
    },
  ];

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final theme = Theme.of(context);

    // Adapter la mise en page pour le mode paysage si nécessaire
    final isLandscape = mediaQuery.orientation == Orientation.landscape;

    return Container(
      color: theme.colorScheme.surface,
      width: mediaQuery.size.width,
      padding: const EdgeInsets.all(16.0),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return isLandscape
              ? _buildLandscapeLayout(context, theme)
              : _buildPortraitLayout(context, theme);
        },
      ),
    );
  }

  // Organisation pour le mode portrait (vertical)
  Widget _buildPortraitLayout(BuildContext context, ThemeData theme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: _buildStyleButtons(context, theme),
    );
  }

  // Organisation pour le mode paysage (horizontal)
  Widget _buildLandscapeLayout(BuildContext context, ThemeData theme) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: _buildStyleButtons(context, theme),
      ),
    );
  }

  // Crée les boutons de style de carte
  List<Widget> _buildStyleButtons(BuildContext context, ThemeData theme) {
    return _mapStyles.map((style) {
      final textStyle = theme.textTheme.bodyMedium?.copyWith(
        fontFamily: "OpenSans-Bold",
        fontSize: 11,
      );

      return InkWell(
        onTap: () {
          Navigator.pop(context);
          onStyleSelected(style['style']);
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Image de style de carte
              Container(
                padding: const EdgeInsets.all(3),
                decoration: const BoxDecoration(
                  color: grey2,
                  shape: BoxShape.circle,
                ),
                child: ClipOval(
                  child: Image.asset(
                    style['image'],
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                    // Optimisation pour le chargement d'images
                    cacheHeight:
                        120, // 2x la taille d'affichage pour les écrans haute résolution
                    cacheWidth: 120,
                  ),
                ),
              ),
              const SizedBox(height: 8.0),
              // Nom du style
              Text(
                style['name'],
                style: textStyle,
              ),
            ],
          ),
        ),
      );
    }).toList();
  }
}
