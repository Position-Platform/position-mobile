import 'package:json_annotation/json_annotation.dart';

import 'sous_category.dart';

part 'category.g.dart';

@JsonSerializable()
class Category {
  int? id;
  String? nom;
  String? shortname;
  String? logourl;
  String? logourlmap;
  String? color;
  int? vues;
  @JsonKey(name: 'sous_categories')
  List<SousCategory>? sousCategories;

  Category({
    this.id,
    this.nom,
    this.shortname,
    this.logourl,
    this.logourlmap,
    this.color,
    this.vues,
    this.sousCategories,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return _$CategoryFromJson(json);
  }

  Map<String, dynamic> toJson() => _$CategoryToJson(this);
}
