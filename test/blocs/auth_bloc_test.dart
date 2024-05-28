import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:position/src/modules/auth/blocs/auth/auth_bloc.dart';

import '../mock/appMock.mocks.dart';

void main() async {
  group('AuthBloc', () {
    late AuthBloc authBloc;
    late MockAuthRepository authRepository;
    late MockSettingRepository settingRepository;
    late MockSharedPreferencesHelper sharedPreferencesHelper;

    setUp(() {
      settingRepository = MockSettingRepository();
      authRepository = MockAuthRepository();
      sharedPreferencesHelper = MockSharedPreferencesHelper();

      authBloc = AuthBloc(
        authRepository: authRepository,
        settingRepository: settingRepository,
        sharedPreferencesHelper: sharedPreferencesHelper,
      );
    });

    tearDown(() {
      authBloc.close();
    });
    blocTest(
      'emits [] when nothing is added',
      build: () => authBloc,
      expect: () => [],
    );
  });
}
