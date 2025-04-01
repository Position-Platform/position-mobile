import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:position/src/core/services/log.service.dart';
import 'package:position/src/modules/auth/blocs/auth/auth_bloc.dart';

class MockLogService extends Mock implements LogService {}

void main() async {
  group('AuthBloc', () {
    late AuthBloc authBloc;
    late LogService logger;

    setUp(() {
      logger = MockLogService();
      authBloc = AuthBloc(logger: logger);
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
