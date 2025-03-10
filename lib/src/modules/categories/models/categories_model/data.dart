import 'package:json_annotation/json_annotation.dart';

import 'category.dart';

part 'data.g.dart';

@JsonSerializable()
class Data {
  List<Category>? categories;

  Data({this.categories});

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}
