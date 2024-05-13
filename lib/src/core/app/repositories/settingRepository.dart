// ignore_for_file: file_names
import 'package:position/src/core/app/models/setting_model/setting.dart';
import 'package:position/src/core/utils/result.dart';

abstract class SettingRepository {
  Future<Result<Setting>> getappsettings(String token);
}
