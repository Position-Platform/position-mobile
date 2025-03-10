// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'categorie.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Categorie _$CategorieFromJson(Map<String, dynamic> json) => Categorie(
      id: (json['id'] as num?)?.toInt(),
      nom: json['nom'] as String?,
      shortname: json['shortname'] as String?,
      logourl: json['logourl'] as String?,
      logourlmap: json['logourlmap'] as String?,
      color: json['color'] as String?,
      vues: (json['vues'] as num?)?.toInt(),
    );

Map<String, dynamic> _$CategorieToJson(Categorie instance) => <String, dynamic>{
      'id': instance.id,
      'nom': instance.nom,
      'shortname': instance.shortname,
      'logourl': instance.logourl,
      'logourlmap': instance.logourlmap,
      'color': instance.color,
      'vues': instance.vues,
    };
