import 'package:json_annotation/json_annotation.dart';

import 'etablissements.dart';
import 'place.dart';

part 'data.g.dart';

@JsonSerializable()
class Data {
  Etablissements? etablissements;
  List<Place>? places;

  Data({this.etablissements, this.places});

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}
