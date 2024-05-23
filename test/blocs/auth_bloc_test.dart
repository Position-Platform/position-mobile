import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:position/src/modules/auth/blocs/auth/auth_bloc.dart';

void main() async {
  group('AuthBloc', () {
    late AuthBloc authBloc;

    setUp(() {
      authBloc = AuthBloc();
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
