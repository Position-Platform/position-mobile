import 'package:json_annotation/json_annotation.dart';

part 'batiment.g.dart';

@JsonSerializable()
class Batiment {
  int? id;
  String? nom;
  @JsonKey(name: 'nombre_niveau')
  int? nombreNiveau;
  String? code;
  String? longitude;
  String? latitude;
  String? image;
  dynamic indication;
  String? rue;
  String? ville;
  dynamic commune;
  String? quartier;

  Batiment({
    this.id,
    this.nom,
    this.nombreNiveau,
    this.code,
    this.longitude,
    this.latitude,
    this.image,
    this.indication,
    this.rue,
    this.ville,
    this.commune,
    this.quartier,
  });

  factory Batiment.fromJson(Map<String, dynamic> json) {
    return _$BatimentFromJson(json);
  }

  Map<String, dynamic> toJson() => _$BatimentToJson(this);
}
