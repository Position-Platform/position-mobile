// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Image _$ImageFromJson(Map<String, dynamic> json) => Image(
      id: (json['id'] as num?)?.toInt(),
      etablissementId: (json['etablissement_id'] as num?)?.toInt(),
      imageUrl: json['image_url'] as String?,
    );

Map<String, dynamic> _$ImageToJson(Image instance) => <String, dynamic>{
      'id': instance.id,
      'etablissement_id': instance.etablissementId,
      'image_url': instance.imageUrl,
    };
