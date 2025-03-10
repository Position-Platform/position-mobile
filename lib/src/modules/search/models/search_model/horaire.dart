import 'package:json_annotation/json_annotation.dart';

part 'horaire.g.dart';

@JsonSerializable()
class Horaire {
  int? id;
  @JsonKey(name: 'etablissement_id')
  int? etablissementId;
  String? jour;
  @JsonKey(name: 'plage_horaire')
  String? plageHoraire;

  Horaire({this.id, this.etablissementId, this.jour, this.plageHoraire});

  factory Horaire.fromJson(Map<String, dynamic> json) {
    return _$HoraireFromJson(json);
  }

  Map<String, dynamic> toJson() => _$HoraireToJson(this);
}
