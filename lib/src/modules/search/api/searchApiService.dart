// ignore_for_file: file_names

import 'package:chopper/chopper.dart';

abstract class SearchApiService {
  Future<Response> search(String query, int userId);
}
