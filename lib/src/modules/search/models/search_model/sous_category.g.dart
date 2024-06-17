// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sous_category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SousCategory _$SousCategoryFromJson(Map<String, dynamic> json) => SousCategory(
      id: (json['id'] as num?)?.toInt(),
      nom: json['nom'] as String?,
      logourl: json['logourl'],
      logourlmap: json['logourlmap'],
      color: json['color'],
      categorie: json['categorie'] == null
          ? null
          : Categorie.fromJson(json['categorie'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SousCategoryToJson(SousCategory instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nom': instance.nom,
      'logourl': instance.logourl,
      'logourlmap': instance.logourlmap,
      'color': instance.color,
      'categorie': instance.categorie,
    };
