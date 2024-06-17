import 'package:json_annotation/json_annotation.dart';

import 'batiment.dart';
import 'commentaire.dart';
import 'count.dart';
import 'horaire.dart';
import 'image.dart';
import 'sous_category.dart';

part 'datum.g.dart';

@JsonSerializable()
class Datum {
  int? id;
  String? nom;
  @JsonKey(name: 'indication_adresse')
  String? indicationAdresse;
  @JsonKey(name: 'code_postal')
  dynamic codePostal;
  @JsonKey(name: 'site_internet')
  String? siteInternet;
  @JsonKey(name: 'nom_manager')
  dynamic nomManager;
  @JsonKey(name: 'contact_manager')
  dynamic contactManager;
  int? etage;
  String? cover;
  String? phone;
  String? whatsapp1;
  dynamic whatsapp2;
  String? description;
  @JsonKey(name: 'osm_id')
  String? osmId;
  String? services;
  String? commodites;
  dynamic ameliorations;
  int? vues;
  dynamic logo;
  @JsonKey(name: 'logo_map')
  dynamic logoMap;
  @JsonKey(name: 'deleted_at')
  dynamic deletedAt;
  @JsonKey(name: 'created_at')
  DateTime? createdAt;
  @JsonKey(name: 'updated_at')
  DateTime? updatedAt;
  bool? isFavoris;
  bool? isopen;
  double? moyenne;
  int? avis;
  List<Count>? count;
  Batiment? batiment;
  @JsonKey(name: 'sous_categories')
  List<SousCategory>? sousCategories;
  List<Image>? images;
  List<Horaire>? horaires;
  List<Commentaire>? commentaires;

  Datum({
    this.id,
    this.nom,
    this.indicationAdresse,
    this.codePostal,
    this.siteInternet,
    this.nomManager,
    this.contactManager,
    this.etage,
    this.cover,
    this.phone,
    this.whatsapp1,
    this.whatsapp2,
    this.description,
    this.osmId,
    this.services,
    this.commodites,
    this.ameliorations,
    this.vues,
    this.logo,
    this.logoMap,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.isFavoris,
    this.isopen,
    this.moyenne,
    this.avis,
    this.count,
    this.sousCategories,
    this.batiment,
    this.images,
    this.horaires,
    this.commentaires,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => _$DatumFromJson(json);

  Map<String, dynamic> toJson() => _$DatumToJson(this);
}
