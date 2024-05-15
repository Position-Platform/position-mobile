import 'package:json_annotation/json_annotation.dart';

import 'data.dart';

part 'setting_model.g.dart';

@JsonSerializable()
class SettingModel {
  bool? success;
  Data? data;
  String? message;

  SettingModel({this.success, this.data, this.message});

  factory SettingModel.fromJson(Map<String, dynamic> json) {
    return _$SettingModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$SettingModelToJson(this);
}
