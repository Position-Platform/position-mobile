import 'package:json_annotation/json_annotation.dart';

import 'setting.dart';

part 'data.g.dart';

@JsonSerializable()
class Data {
  Setting? setting;

  Data({this.setting});

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}
