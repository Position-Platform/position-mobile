// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'datum.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Datum _$DatumFromJson(Map<String, dynamic> json) => Datum(
      id: (json['id'] as num?)?.toInt(),
      nom: json['nom'] as String?,
      indicationAdresse: json['indication_adresse'] as String?,
      codePostal: json['code_postal'],
      siteInternet: json['site_internet'] as String?,
      nomManager: json['nom_manager'],
      contactManager: json['contact_manager'],
      etage: (json['etage'] as num?)?.toInt(),
      cover: json['cover'] as String?,
      phone: json['phone'] as String?,
      whatsapp1: json['whatsapp1'] as String?,
      whatsapp2: json['whatsapp2'],
      description: json['description'] as String?,
      osmId: json['osm_id'] as String?,
      services: json['services'] as String?,
      commodites: json['commodites'] as String?,
      ameliorations: json['ameliorations'],
      vues: (json['vues'] as num?)?.toInt(),
      logo: json['logo'],
      logoMap: json['logo_map'],
      deletedAt: json['deleted_at'],
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      isFavoris: json['isFavoris'] as bool?,
      isopen: json['isopen'] as bool?,
      moyenne: (json['moyenne'] as num?)?.toDouble(),
      avis: (json['avis'] as num?)?.toInt(),
      count: (json['count'] as List<dynamic>?)
          ?.map((e) => Count.fromJson(e as Map<String, dynamic>))
          .toList(),
      sousCategories: (json['sous_categories'] as List<dynamic>?)
          ?.map((e) => SousCategory.fromJson(e as Map<String, dynamic>))
          .toList(),
      batiment: json['batiment'] == null
          ? null
          : Batiment.fromJson(json['batiment'] as Map<String, dynamic>),
      images: (json['images'] as List<dynamic>?)
          ?.map((e) => Image.fromJson(e as Map<String, dynamic>))
          .toList(),
      horaires: (json['horaires'] as List<dynamic>?)
          ?.map((e) => Horaire.fromJson(e as Map<String, dynamic>))
          .toList(),
      commentaires: (json['commentaires'] as List<dynamic>?)
          ?.map((e) => Commentaire.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DatumToJson(Datum instance) => <String, dynamic>{
      'id': instance.id,
      'nom': instance.nom,
      'indication_adresse': instance.indicationAdresse,
      'code_postal': instance.codePostal,
      'site_internet': instance.siteInternet,
      'nom_manager': instance.nomManager,
      'contact_manager': instance.contactManager,
      'etage': instance.etage,
      'cover': instance.cover,
      'phone': instance.phone,
      'whatsapp1': instance.whatsapp1,
      'whatsapp2': instance.whatsapp2,
      'description': instance.description,
      'osm_id': instance.osmId,
      'services': instance.services,
      'commodites': instance.commodites,
      'ameliorations': instance.ameliorations,
      'vues': instance.vues,
      'logo': instance.logo,
      'logo_map': instance.logoMap,
      'deleted_at': instance.deletedAt,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
      'isFavoris': instance.isFavoris,
      'isopen': instance.isopen,
      'moyenne': instance.moyenne,
      'avis': instance.avis,
      'count': instance.count,
      'batiment': instance.batiment,
      'sous_categories': instance.sousCategories,
      'images': instance.images,
      'horaires': instance.horaires,
      'commentaires': instance.commentaires,
    };
