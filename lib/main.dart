// ignore_for_file: avoid_print

import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_performance/firebase_performance.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:position/blocobserver.dart';
import 'package:position/firebase_options.dart';
import 'package:position/src/app.dart';
import 'package:position/src/core/di/di.dart' as di;
import 'package:path_provider/path_provider.dart';
import 'package:position/src/core/services/log.service.dart';
import 'package:position/src/modules/gps/bloc/gps_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  await runZonedGuarded(() async {
    // Initialisation de tous les widgets
    WidgetsFlutterBinding.ensureInitialized();

    // Initialiser le service de logs
    await LogService().initialize();

    // Initialisation des variables d'environement
    await dotenv.load(fileName: ".env");
    // Initialisation des dependences via getIt
    await di.init();
    // Initialisation de Firebase
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    FirebasePerformance.instance;

    // Configuration de HydratedBloc pour la persistance de l'état
    HydratedBloc.storage = await HydratedStorage.build(
      storageDirectory:
          HydratedStorageDirectory((await getTemporaryDirectory()).path),
    );
    // Configuration de l'observateur de BLoC
    Bloc.observer = SimpleBlocObserver();

    // Logger le démarrage de l'application
    LogService().info('Application démarrée');

    // Lancement de l'application
    runApp(BlocProvider(
      create: (_) => di.getIt<GpsBloc>(),
      child: const MyApp(),
    ));
  }, (error, stackTrace) {
    // Gestion des erreurs avec Firebase Crashlytics
    print('runZonedGuarded: Caught error in my root zone.');
    print(stackTrace);
    print(error);
    FirebaseCrashlytics.instance.recordError(error, stackTrace);
  });
}
