import 'package:json_annotation/json_annotation.dart';

import 'address.dart';

part 'place.g.dart';

@JsonSerializable()
class Place {
  @JsonKey(name: 'place_id')
  int? placeId;
  String? licence;
  @JsonKey(name: 'osm_type')
  String? osmType;
  @JsonKey(name: 'osm_id')
  int? osmId;
  List<String>? boundingbox;
  String? lat;
  String? lon;
  @JsonKey(name: 'display_name')
  String? displayName;
  @JsonKey(name: 'class')
  String? placeClass;
  String? type;
  double? importance;
  Address? address;

  Place({
    this.placeId,
    this.licence,
    this.osmType,
    this.osmId,
    this.boundingbox,
    this.lat,
    this.lon,
    this.displayName,
    this.placeClass,
    this.type,
    this.importance,
    this.address,
  });

  factory Place.fromJson(Map<String, dynamic> json) => _$PlaceFromJson(json);

  Map<String, dynamic> toJson() => _$PlaceToJson(this);
}
