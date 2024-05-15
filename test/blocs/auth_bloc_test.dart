import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:position/src/core/helpers/sharedpreferences.dart';
import 'package:position/src/modules/auth/blocs/auth/auth_bloc.dart';
import 'package:position/src/modules/auth/repositories/auth/authRepository.dart';
import 'package:position/src/modules/auth/repositories/setting/settingRepository.dart';

class MockAuthBloc extends MockBloc<AuthEvent, AuthState> implements AuthBloc {}

class MockAuthRepository extends Mock implements AuthRepository {}

class MockSettingRepository extends Mock implements SettingRepository {}

class MockSharedPreferencesHelper extends Mock
    implements SharedPreferencesHelper {}

final authBloc = MockAuthBloc();

void main() async {
  group('AuthBloc', () {
    blocTest(
      'emits [] when nothing is added',
      build: () => authBloc,
      expect: () => [],
    );
  });
}
