// ignore_for_file: file_names

import 'package:chopper/chopper.dart';
import 'package:drift/drift.dart';
import 'package:position/src/modules/auth/api/setting/settingApiService.dart';
import 'package:position/src/modules/auth/db/setting/setting.dao.dart';
import 'package:position/src/modules/auth/models/setting_model/setting.dart';
import 'package:position/src/modules/auth/models/setting_model/setting_model.dart';
import 'package:position/src/modules/auth/repositories/setting/settingRepository.dart';
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
  Future<Result<Setting>> getappsettings() async {
    try {
      // Step 1: Retrieve settings from local database
      final localSetting = await settingDao!.getSetting();

      // Step 2: Check internet connectivity
      bool isConnected = await networkInfoHelper!.isConnected();
      if (isConnected) {
        try {
          // Step 3: Fetch settings from API
          final Response response = await settingApiService!.getappsettings();
          var remoteModel = SettingModel.fromJson(response.body);

          // Step 4: Update local database if there is a change
          if (localSetting == null ||
              localSetting.setting != remoteModel.data!.setting) {
            // If localSetting is null or different from remote, update the database
            if (localSetting != null) {
              await settingDao!.updateSetting(SettingTableCompanion(
                  id: const Value(1),
                  setting: Value(remoteModel.data!.setting)));
            } else {
              await settingDao!.addSetting(SettingTableCompanion(
                  id: const Value(1),
                  setting: Value(remoteModel.data!.setting)));
            }
            return Result(success: remoteModel.data!.setting);
          } else {
            // No change in data
            return Result(success: localSetting.setting);
          }
        } catch (e) {
          // Step 5: Handle server error
          return Result(error: ServerError());
        }
      } else {
        // Step 6: Handle no internet error
        if (localSetting != null) {
          return Result(success: localSetting.setting);
        } else {
          return Result(error: NoInternetError());
        }
      }
    } catch (e) {
      return Result(error: ServerError());
    }
  }
}
