// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class PositionLocalizations {
  PositionLocalizations();

  static PositionLocalizations? _current;

  static PositionLocalizations get current {
    assert(_current != null,
        'No instance of PositionLocalizations was loaded. Try to initialize the PositionLocalizations delegate before accessing PositionLocalizations.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<PositionLocalizations> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = PositionLocalizations();
      PositionLocalizations._current = instance;

      return instance;
    });
  }

  static PositionLocalizations of(BuildContext context) {
    final instance = PositionLocalizations.maybeOf(context);
    assert(instance != null,
        'No instance of PositionLocalizations present in the widget tree. Did you add PositionLocalizations.delegate in localizationsDelegates?');
    return instance!;
  }

  static PositionLocalizations? maybeOf(BuildContext context) {
    return Localizations.of<PositionLocalizations>(
        context, PositionLocalizations);
  }

  /// `Position`
  String get appname {
    return Intl.message(
      'Position',
      name: 'appname',
      desc: '',
      args: [],
    );
  }

  /// `Un accès GPS est nécessaire`
  String get gpsAccess {
    return Intl.message(
      'Un accès GPS est nécessaire',
      name: 'gpsAccess',
      desc: '',
      args: [],
    );
  }

  /// `Assurez-vous d'activer le GPS.`
  String get enableGps {
    return Intl.message(
      'Assurez-vous d\'activer le GPS.',
      name: 'enableGps',
      desc: '',
      args: [],
    );
  }

  /// `Demandez l'access`
  String get askAccess {
    return Intl.message(
      'Demandez l\'access',
      name: 'askAccess',
      desc: '',
      args: [],
    );
  }

  /// `Passer`
  String get skip {
    return Intl.message(
      'Passer',
      name: 'skip',
      desc: '',
      args: [],
    );
  }

  /// `Suivant`
  String get next {
    return Intl.message(
      'Suivant',
      name: 'next',
      desc: '',
      args: [],
    );
  }

  /// `Allez-y`
  String get go {
    return Intl.message(
      'Allez-y',
      name: 'go',
      desc: '',
      args: [],
    );
  }

  /// `Rechercher les points d'intérêt et accéder aux services essentiels de la ville`
  String get title1 {
    return Intl.message(
      'Rechercher les points d\'intérêt et accéder aux services essentiels de la ville',
      name: 'title1',
      desc: '',
      args: [],
    );
  }

  /// `Impression de plan officiel de localisation, partage, enregistrement dans ses favoris ou naviguation d'un endroit vers un autre Pharmacie de garde, banque, centre de santé, écoles, infrastructures sociales et services publics`
  String get subtitle1 {
    return Intl.message(
      'Impression de plan officiel de localisation, partage, enregistrement dans ses favoris ou naviguation d\'un endroit vers un autre Pharmacie de garde, banque, centre de santé, écoles, infrastructures sociales et services publics',
      name: 'subtitle1',
      desc: '',
      args: [],
    );
  }

  /// `Exposer ses compétences, ses produits et services en ligne`
  String get title2 {
    return Intl.message(
      'Exposer ses compétences, ses produits et services en ligne',
      name: 'title2',
      desc: '',
      args: [],
    );
  }

  /// `Une boutique virtuelle et un marché digital pour les activités formelles et informelles ...`
  String get subtitle2 {
    return Intl.message(
      'Une boutique virtuelle et un marché digital pour les activités formelles et informelles ...',
      name: 'subtitle2',
      desc: '',
      args: [],
    );
  }

  /// `Trouver les infos pratiques et consulter l’agenda des manifestations`
  String get title3 {
    return Intl.message(
      'Trouver les infos pratiques et consulter l’agenda des manifestations',
      name: 'title3',
      desc: '',
      args: [],
    );
  }

  /// `Déclarations de Travaux, suivre l’actualité locale via les avis et annonces`
  String get subtitle3 {
    return Intl.message(
      'Déclarations de Travaux, suivre l’actualité locale via les avis et annonces',
      name: 'subtitle3',
      desc: '',
      args: [],
    );
  }

  /// `Reessayez`
  String get tryAgain {
    return Intl.message(
      'Reessayez',
      name: 'tryAgain',
      desc: '',
      args: [],
    );
  }

  /// `Une erreur est survenue`
  String get serverError {
    return Intl.message(
      'Une erreur est survenue',
      name: 'serverError',
      desc: '',
      args: [],
    );
  }

  /// `Pas de connexion internet`
  String get noInternet {
    return Intl.message(
      'Pas de connexion internet',
      name: 'noInternet',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate
    extends LocalizationsDelegate<PositionLocalizations> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'fr'),
      Locale.fromSubtags(languageCode: 'en'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<PositionLocalizations> load(Locale locale) =>
      PositionLocalizations.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
