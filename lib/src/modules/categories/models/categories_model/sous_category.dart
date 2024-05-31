import 'package:json_annotation/json_annotation.dart';

part 'sous_category.g.dart';

@JsonSerializable()
class SousCategory {
  int? id;
  String? nom;
  dynamic logourl;
  dynamic logourlmap;
  dynamic color;

  SousCategory({
    this.id,
    this.nom,
    this.logourl,
    this.logourlmap,
    this.color,
  });

  factory SousCategory.fromJson(Map<String, dynamic> json) {
    return _$SousCategoryFromJson(json);
  }

  Map<String, dynamic> toJson() => _$SousCategoryToJson(this);
}
