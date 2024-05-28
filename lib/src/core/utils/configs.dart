import 'package:flutter_dotenv/flutter_dotenv.dart';

// URL de base pour l'API
const String apiUrl = "https://api-dev.position.cm";

// Clés d'API pour l'authentification
String? apiKey = dotenv.env['API_KEY'];

// Zoom initial pour la carte
const double initialMapZoom = 15.0;

// Mapbox public key
String? mapboxKey = dotenv.env['MAPBOX_ACCESS_TOKEN'];
