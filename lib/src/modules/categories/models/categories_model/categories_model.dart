import 'package:json_annotation/json_annotation.dart';

import 'data.dart';

part 'categories_model.g.dart';

@JsonSerializable()
class CategoriesModel {
  bool? success;
  Data? data;
  String? message;

  CategoriesModel({this.success, this.data, this.message});

  factory CategoriesModel.fromJson(Map<String, dynamic> json) {
    return _$CategoriesModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$CategoriesModelToJson(this);
}
