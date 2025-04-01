// ignore_for_file: file_names

import 'package:chopper/chopper.dart';
import 'package:drift/drift.dart';
import 'package:position/src/core/services/log.service.dart';
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
  final LogService logger;

  SettingRepositoryImpl(
      {this.networkInfoHelper,
      this.settingApiService,
      this.settingDao,
      required this.logger});

  @override
  Future<Result<Setting>> getappsettings() async {
    try {
      // Step 1: Retrieve settings from local database
      final localSetting = await settingDao!.getSetting();
      if (localSetting != null) {
        logger.info("Local setting: ${localSetting.setting}");
      } else {
        logger.info("No local setting found.");
      }

      // Step 2: Check internet connectivity
      bool isConnected = await networkInfoHelper!.isConnected();
      if (isConnected) {
        try {
          logger.info("Connected to the internet. Fetching remote settings.");
          // Step 3: Fetch settings from API
          final Response response = await settingApiService!.getappsettings();

          //log the response
          logger.info("Remote settings response: ${response.body}");

          var remoteModel = SettingModel.fromJson(response.body);

          // log the remote model
          logger.info("Remote model: ${remoteModel.data!.setting}");

          // Step 4: Update local database if there is a change
          if (localSetting == null ||
              localSetting.setting != remoteModel.data!.setting) {
            // If localSetting is null or different from remote, update the database
            if (localSetting != null) {
              await settingDao!.updateSetting(SettingTableCompanion(
                  id: const Value(1),
                  setting: Value(remoteModel.data!.setting)));

              // log the update
              logger
                  .info("Updated local setting: ${remoteModel.data!.setting}");
            } else {
              await settingDao!.addSetting(SettingTableCompanion(
                  id: const Value(1),
                  setting: Value(remoteModel.data!.setting)));

              // log the addition
              logger.info("Added local setting: ${remoteModel.data!.setting}");
            }
            return Result(success: remoteModel.data!.setting);
          } else {
            // No change in data
            return Result(success: localSetting.setting);
          }
        } catch (e) {
          // log the error
          logger.error("Error fetching remote settings: $e");
          // Step 5: Handle server error
          return Result(error: ServerError());
        }
      } else {
        // Step 6: Handle no internet error
        if (localSetting != null) {
          return Result(success: localSetting.setting);
        } else {
          logger.error("No internet connection and no local settings found.");
          return Result(error: NoInternetError());
        }
      }
    } catch (e) {
      // log the error
      logger.error("Error in getappsettings: $e");
      return Result(error: ServerError());
    }
  }
}
