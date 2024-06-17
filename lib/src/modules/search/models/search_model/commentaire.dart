import 'package:json_annotation/json_annotation.dart';

import 'user.dart';

part 'commentaire.g.dart';

@JsonSerializable()
class Commentaire {
  int? id;
  @JsonKey(name: 'user_id')
  int? userId;
  String? commentaire;
  int? rating;
  @JsonKey(name: 'deleted_at')
  dynamic deletedAt;
  @JsonKey(name: 'created_at')
  DateTime? createdAt;
  @JsonKey(name: 'updated_at')
  DateTime? updatedAt;
  User? user;

  Commentaire({
    this.id,
    this.userId,
    this.commentaire,
    this.rating,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.user,
  });

  factory Commentaire.fromJson(Map<String, dynamic> json) {
    return _$CommentaireFromJson(json);
  }

  Map<String, dynamic> toJson() => _$CommentaireToJson(this);
}
