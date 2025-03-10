// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Address _$AddressFromJson(Map<String, dynamic> json) => Address(
      amenity: json['amenity'] as String?,
      road: json['road'] as String?,
      suburb: json['suburb'] as String?,
      village: json['village'] as String?,
      city: json['city'] as String?,
      municipality: json['municipality'] as String?,
      county: json['county'] as String?,
      state: json['state'] as String?,
      iso31662Lvl4: json['ISO3166-2-lvl4'] as String?,
      country: json['country'] as String?,
      countryCode: json['country_code'] as String?,
    );

Map<String, dynamic> _$AddressToJson(Address instance) => <String, dynamic>{
      'amenity': instance.amenity,
      'road': instance.road,
      'suburb': instance.suburb,
      'village': instance.village,
      'city': instance.city,
      'municipality': instance.municipality,
      'county': instance.county,
      'state': instance.state,
      'ISO3166-2-lvl4': instance.iso31662Lvl4,
      'country': instance.country,
      'country_code': instance.countryCode,
    };
