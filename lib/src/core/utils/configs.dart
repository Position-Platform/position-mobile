import 'package:flutter_dotenv/flutter_dotenv.dart';

// URL de base pour l'API
const String apiUrl = "https://api.position.cm";

// Clés d'API pour l'authentification
String? apiKey = dotenv.env['API_KEY'];
