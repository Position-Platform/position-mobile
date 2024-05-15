// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:position/generated/l10n.dart';
import 'package:position/src/core/utils/colors.dart';
import 'package:position/src/core/utils/tools.dart';
import 'package:position/src/modules/auth/blocs/auth/auth_bloc.dart';
import 'package:position/src/onboarding.dart';
import 'package:position/src/splash.dart';
import 'package:position/src/widgets/error.dart';

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
          return Scaffold(
            body: Center(
              child: Text(
                state.settings.appName!,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          );
        }
        // Si l'état est AuthSuccess, afficher la carte avec la position de l'utilisateur
        if (state is AuthSuccess) {}
        // Si l'état est AuthNoInternet, afficher un message d'erreur indiquant que l'application n'a pas accès à Internet
        if (state is AuthNoInternet) {
          return errorWidget(
              context,
              PositionLocalizations.of(context).noInternet,
              () => BlocProvider.of<AuthBloc>(context).add(AuthStarted()));
        }
        // Si l'état est AuthServerError, afficher un message d'erreur indiquant qu'il y a eu une erreur de serveur
        if (state is AuthServerError) {
          return errorWidget(
              context,
              PositionLocalizations.of(context).serverError,
              () => BlocProvider.of<AuthBloc>(context).add(AuthStarted()));
        }

        // Par défaut, afficher l'écran de chargement
        return const SplashScreen();
      },
    );
  }
}
