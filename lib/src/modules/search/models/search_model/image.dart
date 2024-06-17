import 'package:json_annotation/json_annotation.dart';

part 'image.g.dart';

@JsonSerializable()
class Image {
  int? id;
  @JsonKey(name: 'etablissement_id')
  int? etablissementId;
  @JsonKey(name: 'image_url')
  String? imageUrl;

  Image({this.id, this.etablissementId, this.imageUrl});

  factory Image.fromJson(Map<String, dynamic> json) => _$ImageFromJson(json);

  Map<String, dynamic> toJson() => _$ImageToJson(this);
}
