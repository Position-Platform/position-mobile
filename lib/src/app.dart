// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:position/generated/l10n.dart';
import 'package:position/src/core/di/di.dart';
import 'package:position/src/modules/app/bloc/app_bloc.dart';
import 'package:position/src/modules/gps/views/loading.dart';
import 'package:position/src/modules/map/bloc/map/map_bloc.dart';

class MyApp extends StatelessWidget {
  // Le constructeur prend un paramètre initialLink et appelle le constructeur de la classe parent avec la clé et le paramètre initialLink.
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          // Le bloc AppBloc est fourni à l'ensemble de l'application.
          BlocProvider(
            create: (context) => AppBloc(),
          ),
          BlocProvider<MapBloc>(
            create: (context) => getIt<MapBloc>(),
          ),
        ],
        child: BlocBuilder<AppBloc, AppState>(
          builder: (context, state) {
            return MaterialApp(
              // Le titre de l'application.
              title: "Position",
              // Le thème de l'application est défini en fonction de l'état actuel de l'application.
              theme: state.themeData,
              // Les délégués de localisation sont utilisés pour traduire le texte de l'application dans la langue préférée de l'utilisateur.
              localizationsDelegates: const [
                PositionLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
              ],
              // La langue préférée de l'utilisateur est définie en fonction de l'état actuel de l'application.
              locale: state.locale,
              // La liste des langues que l'application prend en charge.
              supportedLocales: PositionLocalizations.delegate.supportedLocales,
              // Désactive la bannière de débogage.
              debugShowCheckedModeBanner: false,
              // Le widget LoadingPage est affiché en tant que page d'accueil de l'application.
              home: const LoadingPage(),
            );
          },
        ));
  }
}
