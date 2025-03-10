// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      email: json['email'] as String?,
      emailVerifiedAt: json['email_verified_at'] == null
          ? null
          : DateTime.parse(json['email_verified_at'] as String),
      phone: json['phone'] as String?,
      fcmToken: json['fcm_token'],
      imageProfil: json['image_profil'] as String?,
      abonnementId: (json['abonnement_id'] as num?)?.toInt(),
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'email_verified_at': instance.emailVerifiedAt?.toIso8601String(),
      'phone': instance.phone,
      'fcm_token': instance.fcmToken,
      'image_profil': instance.imageProfil,
      'abonnement_id': instance.abonnementId,
    };
