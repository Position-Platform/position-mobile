import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  int? id;
  String? name;
  String? email;
  @JsonKey(name: 'email_verified_at')
  DateTime? emailVerifiedAt;
  String? phone;
  @JsonKey(name: 'fcm_token')
  dynamic fcmToken;
  @JsonKey(name: 'image_profil')
  String? imageProfil;
  @JsonKey(name: 'abonnement_id')
  int? abonnementId;

  User({
    this.id,
    this.name,
    this.email,
    this.emailVerifiedAt,
    this.phone,
    this.fcmToken,
    this.imageProfil,
    this.abonnementId,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
