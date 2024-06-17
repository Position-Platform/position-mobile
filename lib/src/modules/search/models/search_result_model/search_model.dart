import 'package:json_annotation/json_annotation.dart';
import 'package:position/src/modules/search/models/search_model/categorie.dart';
import 'package:position/src/modules/search/models/search_model/datum.dart';

part 'search_model.g.dart';

@JsonSerializable()
class SearchResultModel {
  String? name;
  String? id;
  String? type;
  String? logo;
  String? logomap;
  String? details;
  String? longitude;
  String? latitude;
  Datum? etablissement;
  Categorie? category;
  bool? isOpenNow;
  double? distance;
  String? plageDay;

  SearchResultModel(
      {this.name,
      this.id,
      this.type,
      this.logo,
      this.logomap,
      this.details,
      this.longitude,
      this.latitude,
      this.etablissement,
      this.category,
      this.isOpenNow,
      this.distance,
      this.plageDay});

  @override
  String toString() {
    return 'SearchModel(name: $name, id: $id, type: $type, logo: $logo, logomap:$logomap, details: $details, longitude: $longitude, latitude: $latitude,etablissement: $etablissement,category:$category,isOpenNow:$isOpenNow,distance:$distance, plageDay:$plageDay)';
  }

  factory SearchResultModel.fromJson(Map<String, dynamic> json) {
    return _$SearchModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$SearchModelToJson(this);

  SearchResultModel copyWith(
      {String? name,
      String? id,
      String? type,
      String? logo,
      String? logomap,
      String? details,
      String? longitude,
      String? latitude,
      Datum? etablissement,
      Categorie? category,
      bool? isOpenNow,
      double? distance,
      String? plageDay}) {
    return SearchResultModel(
        name: name ?? this.name,
        id: id ?? this.id,
        type: type ?? this.type,
        logo: logo ?? this.logo,
        logomap: logomap ?? logomap,
        details: details ?? this.details,
        longitude: longitude ?? this.longitude,
        latitude: latitude ?? this.latitude,
        etablissement: etablissement ?? this.etablissement,
        category: category ?? this.category,
        isOpenNow: isOpenNow ?? this.isOpenNow,
        distance: distance ?? this.distance,
        plageDay: plageDay ?? plageDay);
  }
}
