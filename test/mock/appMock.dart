// ignore_for_file: file_names

import 'package:mockito/annotations.dart';
import 'package:position/src/core/helpers/network.dart';
import 'package:position/src/core/helpers/sharedpreferences.dart';
import 'package:position/src/core/services/apiService.dart';
import 'package:position/src/modules/auth/api/auth/authApiService.dart';
import 'package:position/src/modules/auth/api/setting/settingApiService.dart';
import 'package:position/src/modules/auth/db/setting/setting.dao.dart';
import 'package:position/src/modules/auth/db/user/user.dao.dart';
import 'package:position/src/modules/auth/models/setting_model/setting.dart';
import 'package:position/src/modules/auth/models/user_model/user.dart';
import 'package:position/src/modules/auth/repositories/auth/authRepository.dart';
import 'package:position/src/modules/auth/repositories/setting/settingRepository.dart';

@GenerateMocks([
  ApiService,
  AuthApiService,
  SettingApiService,
  AuthRepository,
  SettingRepository,
  SettingDao,
  UserDao,
  SharedPreferencesHelper,
  NetworkInfoHelper,
  User,
  Setting
])
void main() {}
