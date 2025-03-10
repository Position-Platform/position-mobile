// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      etablissements: json['etablissements'] == null
          ? null
          : Etablissements.fromJson(
              json['etablissements'] as Map<String, dynamic>),
      places: (json['places'] as List<dynamic>?)
          ?.map((e) => Place.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'etablissements': instance.etablissements,
      'places': instance.places,
    };
