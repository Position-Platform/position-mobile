// ignore_for_file: file_names

import 'package:chopper/chopper.dart';
import 'package:position/src/core/helpers/network.dart';
import 'package:position/src/core/utils/result.dart';
import 'package:position/src/modules/search/api/searchApiService.dart';
import 'package:position/src/modules/search/models/search_model/search_model.dart';
import 'package:position/src/modules/search/repositories/searchRepository.dart';

class SearchRepositoryImpl implements SearchRepository {
  final NetworkInfoHelper? networkInfoHelper;
  final SearchApiService? searchApiService;

  SearchRepositoryImpl({
    this.networkInfoHelper,
    this.searchApiService,
  });

  @override
  Future<Result<SearchModel>> search(String query, int userId) async {
    bool isConnected = await networkInfoHelper!.isConnected();
    if (isConnected) {
      try {
        final Response response = await searchApiService!.search(query, userId);

        var model = SearchModel.fromJson(response.body);

        return Result(success: model);
      } catch (e) {
        return Result(error: ServerError());
      }
    } else {
      return Result(error: NoInternetError());
    }
  }
}
