import 'package:json_annotation/json_annotation.dart';

import 'data.dart';

part 'search_model.g.dart';

@JsonSerializable()
class SearchModel {
  bool? success;
  Data? data;
  String? message;

  SearchModel({this.success, this.data, this.message});

  factory SearchModel.fromJson(Map<String, dynamic> json) {
    return _$SearchModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$SearchModelToJson(this);
}
