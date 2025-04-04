// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:position/src/core/di/di.dart';
import 'package:position/src/init.dart';
import 'package:position/src/modules/auth/blocs/auth/auth_bloc.dart';
import 'package:position/src/modules/gps/bloc/gps_bloc.dart';
import 'package:position/src/modules/gps/views/gpspage.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<GpsBloc, GpsState>(
        builder: (context, state) {
          return state.isAllGranted
              ? BlocProvider<AuthBloc>(
                  create: (context) => getIt<AuthBloc>()..add(AuthStarted()),
                  child: const InitPage(),
                )
              : const GpsAccessPage();
        },
      ),
    );
  }
}
