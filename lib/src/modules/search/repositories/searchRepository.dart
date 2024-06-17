// ignore_for_file: file_names

import 'package:position/src/core/utils/result.dart';
import 'package:position/src/modules/search/models/search_model/search_model.dart';

abstract class SearchRepository {
  Future<Result<SearchModel>> search(String query, int userId);
}
