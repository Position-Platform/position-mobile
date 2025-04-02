// ignore_for_file: file_names, avoid_print

import 'package:position/src/core/services/log.service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  final LogService _logger = LogService();

  // Clés existantes
  final String _isFirstOpen = "firstOpen";
  final String _token = "token";

  // Nouvelles clés pour le module catégories
  final String _categoriesLastCacheTime = "categories_last_cache_time";

  // Méthodes existantes
  Future<bool> setIsFirstOpen(bool first) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool res = await prefs.setBool(_isFirstOpen, first);
    _logger.info('First Open $res');
    print('First Open $res');
    return res;
  }

  Future<bool> getIsFirstOpen() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool res = prefs.getBool(_isFirstOpen) ?? true;
    _logger.info('First Open $res');
    print('First Open $res');
    return res;
  }

  Future<bool> setToken(String token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool res = await prefs.setString(_token, "Bearer $token");
    _logger.info('Token $res');
    print('Token $res');
    return res;
  }

  Future<bool> deleteToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool res = await prefs.remove(_token);
    _logger.info('Token $res');
    print('Token $res');
    return res;
  }

  Future<String?> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? res = prefs.getString(_token);
    _logger.info('Token $res');
    print('Token $res');
    return res;
  }

  // Nouvelles méthodes pour la gestion du cache des catégories

  /// Enregistre le timestamp de dernière mise à jour du cache des catégories
  Future<bool> setCategoriesLastCacheTime(int timestamp) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool res =
        await prefs.setString(_categoriesLastCacheTime, timestamp.toString());
    _logger.info('Categories last cache time set: $timestamp');
    return res;
  }

  /// Récupère le timestamp de dernière mise à jour du cache des catégories
  Future<int?> getCategoriesLastCacheTime() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? timestampStr = prefs.getString(_categoriesLastCacheTime);
    if (timestampStr == null) {
      _logger.info('Categories last cache time not found');
      return null;
    }

    try {
      int timestamp = int.parse(timestampStr);
      _logger.info('Categories last cache time: $timestamp');
      return timestamp;
    } catch (e) {
      _logger.error('Error parsing categories last cache time: $e');
      return null;
    }
  }

  /// Supprime le timestamp de dernière mise à jour du cache des catégories
  Future<bool> deleteCategoriesLastCacheTime() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool res = await prefs.remove(_categoriesLastCacheTime);
    _logger.info('Categories last cache time deleted: $res');
    return res;
  }

  /// Méthode générique pour supprimer une entrée par sa clé
  Future<bool> removeKey(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool res = await prefs.remove(key);
    _logger.info('Key removed: $key, result: $res');
    return res;
  }
}
