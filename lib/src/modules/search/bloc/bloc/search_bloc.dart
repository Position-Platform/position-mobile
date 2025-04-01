// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:position/src/core/services/log.service.dart';
import 'package:position/src/core/utils/configs.dart';
import 'package:position/src/modules/auth/models/user_model/user.dart';
import 'package:position/src/modules/search/models/search_model/datum.dart';
import 'package:position/src/modules/search/models/search_model/place.dart';
import 'package:position/src/modules/search/models/search_result_model/search_model.dart';
import 'package:position/src/modules/search/repositories/searchRepository.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchRepository? searchRepository;
  LogService logger;
  SearchBloc({
    this.searchRepository,
    required this.logger,
  }) : super(SearchInitial()) {
    on<MakeSearch>(_search);
  }

  void _search(
    MakeSearch event,
    Emitter<SearchState> emit,
  ) async {
    emit(SearchLoading());

    try {
      var searchResults =
          await searchRepository!.search(event.query!, event.user!.id!);
      // Log the search results
      logger.info('Search results: ${searchResults.success}');

      List<SearchResultModel> searchResultsModel = [
        ...await _getEtablissementFromResponse(
            searchResults.success!.data!.etablissements!.data!),
        ...await _getPlacesFromResponse(searchResults.success!.data!.places!)
      ];
      // Log the transformed search results
      logger.info('Transformed search results: $searchResultsModel');

      emit(SearchLoaded(searchResultsModel));
    } catch (e) {
      emit(SearchError());
    }
  }

  Future<List<SearchResultModel>> _getPlacesFromResponse(
      List<Place> places) async {
    // Log the places data
    logger.info('Places data: $places');
    return [
      for (var i = 0; i < places.length; i++)
        SearchResultModel(
          name: places[i].displayName,
          details: places[i].address!.country,
          type: "nominatim",
          id: places[i].osmId.toString(),
          longitude: places[i].lon,
          latitude: places[i].lat,
          logo: "$apiUrl/images/icon-icon-position-pin.png",
          logomap: "$apiUrl/images/icon-icon-position-pin.png",
        )
    ];
  }

  Future<List<SearchResultModel>> _getEtablissementFromResponse(
      List<Datum> etablissements) async {
    // Log the etablissements data
    logger.info('Etablissements data: $etablissements');
    return [
      for (var i = 0; i < etablissements.length; i++)
        SearchResultModel(
            name: etablissements[i].nom,
            details:
                "${etablissements[i].sousCategories![0].nom!} , ${etablissements[i].batiment!.ville!}",
            type: "etablissement",
            id: etablissements[i].id.toString(),
            longitude: etablissements[i].batiment!.longitude,
            latitude: etablissements[i].batiment!.latitude,
            logo: etablissements[i].logo ??
                etablissements[i].sousCategories![0].logourl ??
                etablissements[i].sousCategories![0].categorie!.logourl,
            logomap: etablissements[i].logoMap ??
                etablissements[i].sousCategories![0].logourlmap ??
                etablissements[i].sousCategories![0].categorie!.logourlmap,
            etablissement: etablissements[i],
            isOpenNow: etablissements[i].isopen,
            plageDay: checkIfEtablissementIsOpen(etablissements[i]))
    ];
  }

  // Fonction pour vérifier si un établissement est ouvert
  String checkIfEtablissementIsOpen(Datum etablissement) {
    var now = DateTime.now().weekday;
    String plageHoraire = "";

    // Utilisation de constantes pour les jours de la semaine
    const String lundi = "Lundi";
    const String mardi = "Mardi";
    const String mercredi = "Mercredi";
    const String jeudi = "Jeudi";
    const String vendredi = "Vendredi";
    const String samedi = "Samedi";
    const String dimanche = "Dimanche";

    for (var i = 0; i < etablissement.horaires!.length; i++) {
      if (etablissement.horaires![i].jour == lundi && now == 1) {
        plageHoraire = etablissement.horaires![i].plageHoraire!;
      } else if (etablissement.horaires![i].jour == mardi && now == 2) {
        plageHoraire = etablissement.horaires![i].plageHoraire!;
      } else if (etablissement.horaires![i].jour == mercredi && now == 3) {
        plageHoraire = etablissement.horaires![i].plageHoraire!;
      } else if (etablissement.horaires![i].jour == jeudi && now == 4) {
        plageHoraire = etablissement.horaires![i].plageHoraire!;
      } else if (etablissement.horaires![i].jour == vendredi && now == 5) {
        plageHoraire = etablissement.horaires![i].plageHoraire!;
      } else if (etablissement.horaires![i].jour == samedi && now == 6) {
        plageHoraire = etablissement.horaires![i].plageHoraire!;
      } else if (etablissement.horaires![i].jour == dimanche && now == 7) {
        plageHoraire = etablissement.horaires![i].plageHoraire!;
      }
    }
    // Log the opening hours for the establishment
    logger.info(
        'Opening hours for ${etablissement.nom}: $plageHoraire on day $now');

    return plageHoraire;
  }
}
