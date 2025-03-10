// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:position/generated/l10n.dart';
import 'package:position/src/core/di/di.dart';
import 'package:position/src/core/utils/colors.dart';
import 'package:position/src/core/utils/tools.dart';
import 'package:position/src/modules/auth/blocs/auth/auth_bloc.dart';
import 'package:position/src/modules/auth/blocs/login/login_bloc.dart';
import 'package:position/src/modules/auth/views/loginPage.dart';
import 'package:position/src/modules/map/views/mapPage.dart';
import 'package:position/src/onboarding.dart';
import 'package:position/src/splash.dart';
import 'package:position/src/widgets/positionErrorWidget.dart';

class InitPage extends StatelessWidget {
  // Constructeur de la classe InitPage
  const InitPage({super.key});

  @override
  Widget build(BuildContext context) {
    changeStatusColor(whiteColor);
    // Utilisation d'un BlocBuilder pour écouter les changements d'état du AuthBloc
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        // Si l'état est AuthInitial, afficher l'écran de chargement
        if (state is AuthInitial) {
          return const SplashScreen();
        }
        // Si l'état est AuthFirstOpen, afficher l'écran d'introduction
        if (state is AuthFirstOpen) {
          return const OnboardingScreen();
        }
        // Si l'état est AuthFailure, vérifier si initialLink est différent de null
        if (state is AuthFailure) {
          return BlocProvider<LoginBloc>(
            create: (context) => getIt<LoginBloc>(),
            child: LoginPage(
              setting: state.settings,
            ),
          );
        }
        // Si l'état est AuthSuccess, afficher la carte avec la position de l'utilisateur
        if (state is AuthSuccess) {
          return MapPage(
            setting: state.settings,
            user: state.user,
          );
        }
        // Si l'état est AuthNoInternet, afficher un message d'erreur indiquant que l'application n'a pas accès à Internet
        if (state is AuthNoInternet) {
          return PositionErrorWidget(
              message: PositionLocalizations.of(context).noInternet,
              onPressed: () =>
                  BlocProvider.of<AuthBloc>(context).add(AuthStarted()));
        }
        // Si l'état est AuthServerError, afficher un message d'erreur indiquant qu'il y a eu une erreur de serveur
        if (state is AuthServerError) {
          return PositionErrorWidget(
              message: PositionLocalizations.of(context).serverError,
              onPressed: () =>
                  BlocProvider.of<AuthBloc>(context).add(AuthStarted()));
        }

        // Si l'état est AuthMaintenance, afficher un message d'erreur indiquant que l'application est en cours de maintenance
        if (state is AuthMaintenance) {
          return PositionErrorWidget(
              message: PositionLocalizations.of(context).maintenance,
              onPressed: () =>
                  BlocProvider.of<AuthBloc>(context).add(AuthStarted()));
        }
        // Par défaut, afficher l'écran de chargement
        return const SplashScreen();
      },
    );
  }
}
