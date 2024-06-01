// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:position/src/core/utils/colors.dart';

class PositionStyleSelection extends StatefulWidget {
  const PositionStyleSelection({super.key, required this.onStyleSelected});
  final Function(String style) onStyleSelected;

  @override
  State<PositionStyleSelection> createState() => _PositionStyleSelectionState();
}

class _PositionStyleSelectionState extends State<PositionStyleSelection> {
  final List<Map<String, dynamic>> cardStyles = [
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
    /*{
      'name': 'Dark',
      'image': 'assets/images/png/dark.png',
      'style': MapboxStyles.DARK
    },*/
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.min,
        children: cardStyles.map((style) {
          return InkWell(
            onTap: () {
              // Fermer le BottomSheet et appliquer le style sélectionné
              Navigator.pop(context);
              widget.onStyleSelected(style['style']);
            },
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.all(3), // Border width
                    decoration: const BoxDecoration(
                        color: grey2, shape: BoxShape.circle),
                    child: ClipOval(
                      child: SizedBox.fromSize(
                        // Image radius
                        child: Image.asset(style['image'],
                            width: 60, height: 60, fit: BoxFit.cover),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    style['name'],
                    style: const TextStyle(
                      fontSize: 10.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: "OpenSans",
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
