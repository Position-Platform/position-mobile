// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'place.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Place _$PlaceFromJson(Map<String, dynamic> json) => Place(
      placeId: (json['place_id'] as num?)?.toInt(),
      licence: json['licence'] as String?,
      osmType: json['osm_type'] as String?,
      osmId: (json['osm_id'] as num?)?.toInt(),
      boundingbox: (json['boundingbox'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      lat: json['lat'] as String?,
      lon: json['lon'] as String?,
      displayName: json['display_name'] as String?,
      placeClass: json['class'] as String?,
      type: json['type'] as String?,
      importance: (json['importance'] as num?)?.toDouble(),
      address: json['address'] == null
          ? null
          : Address.fromJson(json['address'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PlaceToJson(Place instance) => <String, dynamic>{
      'place_id': instance.placeId,
      'licence': instance.licence,
      'osm_type': instance.osmType,
      'osm_id': instance.osmId,
      'boundingbox': instance.boundingbox,
      'lat': instance.lat,
      'lon': instance.lon,
      'display_name': instance.displayName,
      'class': instance.placeClass,
      'type': instance.type,
      'importance': instance.importance,
      'address': instance.address,
    };
