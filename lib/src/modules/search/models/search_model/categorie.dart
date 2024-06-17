import 'package:json_annotation/json_annotation.dart';

part 'categorie.g.dart';

@JsonSerializable()
class Categorie {
  int? id;
  String? nom;
  String? shortname;
  String? logourl;
  String? logourlmap;
  String? color;
  int? vues;

  Categorie({
    this.id,
    this.nom,
    this.shortname,
    this.logourl,
    this.logourlmap,
    this.color,
    this.vues,
  });

  factory Categorie.fromJson(Map<String, dynamic> json) {
    return _$CategorieFromJson(json);
  }

  Map<String, dynamic> toJson() => _$CategorieToJson(this);
}
