// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'count.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Count _$CountFromJson(Map<String, dynamic> json) => Count(
      count: (json['count'] as num?)?.toInt(),
      rating: (json['rating'] as num?)?.toInt(),
    );

Map<String, dynamic> _$CountToJson(Count instance) => <String, dynamic>{
      'count': instance.count,
      'rating': instance.rating,
    };
