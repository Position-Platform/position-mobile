// ignore_for_file: file_names

import 'package:chopper/chopper.dart';
import 'package:position/src/core/helpers/network.dart';
import 'package:position/src/core/services/log.service.dart';
import 'package:position/src/core/utils/result.dart';
import 'package:position/src/modules/search/api/searchApiService.dart';
import 'package:position/src/modules/search/models/search_model/search_model.dart';
import 'package:position/src/modules/search/repositories/searchRepository.dart';

class SearchRepositoryImpl implements SearchRepository {
  final NetworkInfoHelper? networkInfoHelper;
  final SearchApiService? searchApiService;
  final LogService logger;

  SearchRepositoryImpl({
    this.networkInfoHelper,
    this.searchApiService,
    required this.logger,
  });

  @override
  Future<Result<SearchModel>> search(String query, int userId) async {
    bool isConnected = await networkInfoHelper!.isConnected();
    if (isConnected) {
      try {
        // Log the search query and user ID
        logger.info('Search request with query: $query and user ID: $userId');
        final Response response = await searchApiService!.search(query, userId);

        // Log the response from the API
        logger.info('Search response: ${response.body}');

        var model = SearchModel.fromJson(response.body);
        // Log the model
        logger.info('Search model: ${model.data}');

        return Result(success: model);
      } catch (e) {
        // Log the error
        logger.error('Caught error during search: ${e.toString()}');
        return Result(error: ServerError());
      }
    } else {
      // Log the no internet connection error
      logger.error('No internet connection');
      return Result(error: NoInternetError());
    }
  }
}
