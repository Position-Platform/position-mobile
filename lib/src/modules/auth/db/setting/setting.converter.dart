import 'package:drift/drift.dart';
import 'package:position/src/modules/auth/models/setting_model/setting.dart';
import 'dart:convert';

class SettingConverter extends TypeConverter<Setting, String> {
  const SettingConverter();

  @override
  Setting fromSql(String fromDb) {
    return Setting.fromJson(json.decode(fromDb) as Map<String, dynamic>);
  }

  @override
  String toSql(Setting value) {
    return json.encode(value.toJson());
  }
}
