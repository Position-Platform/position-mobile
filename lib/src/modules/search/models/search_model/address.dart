import 'package:json_annotation/json_annotation.dart';

part 'address.g.dart';

@JsonSerializable()
class Address {
  String? amenity;
  String? road;
  String? suburb;
  String? village;
  String? city;
  String? municipality;
  String? county;
  String? state;
  @JsonKey(name: 'ISO3166-2-lvl4')
  String? iso31662Lvl4;
  String? country;
  @JsonKey(name: 'country_code')
  String? countryCode;

  Address({
    this.amenity,
    this.road,
    this.suburb,
    this.village,
    this.city,
    this.municipality,
    this.county,
    this.state,
    this.iso31662Lvl4,
    this.country,
    this.countryCode,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return _$AddressFromJson(json);
  }

  Map<String, dynamic> toJson() => _$AddressToJson(this);
}
