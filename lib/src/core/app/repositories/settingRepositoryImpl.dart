// ignore_for_file: file_names

import 'package:chopper/chopper.dart';
import 'package:drift/drift.dart';
import 'package:position/src/core/app/api/settingApiService.dart';
import 'package:position/src/core/app/db/setting.dao.dart';
import 'package:position/src/core/app/models/setting_model/setting.dart';
import 'package:position/src/core/app/models/setting_model/setting_model.dart';
import 'package:position/src/core/app/repositories/settingRepository.dart';
import 'package:position/src/core/database/db.dart';
import 'package:position/src/core/helpers/network.dart';
import 'package:position/src/core/utils/result.dart';

class SettingRepositoryImpl implements SettingRepository {
  final NetworkInfoHelper? networkInfoHelper;
  final SettingApiService? settingApiService;
  final SettingDao? settingDao;

  SettingRepositoryImpl(
      {this.networkInfoHelper, this.settingApiService, this.settingDao});

  @override
  Future<Result<Setting>> getappsettings(String token) async {
    bool isConnected = await networkInfoHelper!.isConnected();
    if (isConnected) {
      try {
        final Response response =
            await settingApiService!.getappsettings(token);

        var model = SettingModel.fromJson(response.body);

        // check if setting is already in db
        final setting = await settingDao!.getSetting();

        if (setting != null) {
          await settingDao!.updateSetting(SettingTableCompanion(
              id: const Value(1), setting: Value(model.data!.setting)));
        } else {
          await settingDao!.addSetting(SettingTableCompanion(
              id: const Value(1), setting: Value(model.data!.setting)));
        }
        return Result(success: model.data!.setting);
      } catch (e) {
        return Result(error: ServerError());
      }
    } else {
      return Result(error: NoInternetError());
    }
  }
}
