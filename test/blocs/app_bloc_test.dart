// ignore_for_file: depend_on_referenced_packages

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:position/src/core/services/log.service.dart';
import 'package:position/src/core/utils/themes.dart';
import 'package:test/test.dart';

import 'package:position/src/modules/app/bloc/app_bloc.dart';

class MockHydratedBlocStorage extends Mock implements HydratedStorage {}

class MockLogService extends Mock implements LogService {}

void main() {
  late HydratedStorage storage;
  late LogService logger;

  setUp(() async {
    storage = MockHydratedBlocStorage();
    logger = MockLogService();
    when(() => storage.write(any(), any<dynamic>())).thenAnswer((_) async {});
    when<dynamic>(() => storage.read(any())).thenReturn(null);
    when(() => storage.delete(any())).thenAnswer((_) async {});
    HydratedBloc.storage = storage;
  });

  group('AppBloc', () {
    late AppBloc appBloc;

    setUp(() {
      appBloc = AppBloc(logger: logger);
    });

    test('initial state is correct', () {
      expect(
          appBloc.state,
          AppState(AppThemes.appThemeData[AppTheme.lightTheme],
              const Locale('fr', 'FR')));
    });

    blocTest<AppBloc, AppState>(
      'emits [AppState(themeData: dark, locale: en)] when ChangeTheme(AppTheme.darkTheme) is added',
      build: () => appBloc,
      act: (bloc) => bloc.add(const ChangeTheme(AppTheme.darkTheme)),
      expect: () => [
        AppState(AppThemes.appThemeData[AppTheme.darkTheme],
            const Locale('fr', 'FR'))
      ],
    );

    blocTest<AppBloc, AppState>(
      'emits [AppState(themeData: light, locale: en)] when ChangeLanguage(Locale(\'en\', \'US\')) is added',
      build: () => appBloc,
      act: (bloc) => bloc.add(const ChangeLanguage(Locale('en', 'US'))),
      expect: () => [
        AppState(AppThemes.appThemeData[AppTheme.lightTheme],
            const Locale('en', 'US'))
      ],
    );

    blocTest<AppBloc, AppState>(
      'emits [AppState(themeData: light, locale: en)] when invalid event is added',
      build: () => appBloc,
      act: (bloc) => bloc.add(const ChangeTheme(AppTheme.lightTheme)),
      expect: () => [
        AppState(AppThemes.appThemeData[AppTheme.lightTheme],
            const Locale('fr', 'FR'))
      ],
    );

    tearDown(() {
      appBloc.close();
    });
  });
}
