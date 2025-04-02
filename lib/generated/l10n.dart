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
    assert(
      _current != null,
      'No instance of PositionLocalizations was loaded. Try to initialize the PositionLocalizations delegate before accessing PositionLocalizations.current.',
    );
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
    assert(
      instance != null,
      'No instance of PositionLocalizations present in the widget tree. Did you add PositionLocalizations.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static PositionLocalizations? maybeOf(BuildContext context) {
    return Localizations.of<PositionLocalizations>(
      context,
      PositionLocalizations,
    );
  }

  /// `Position`
  String get appname {
    return Intl.message('Position', name: 'appname', desc: '', args: []);
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
    return Intl.message('Passer', name: 'skip', desc: '', args: []);
  }

  /// `Suivant`
  String get next {
    return Intl.message('Suivant', name: 'next', desc: '', args: []);
  }

  /// `Allez-y`
  String get go {
    return Intl.message('Allez-y', name: 'go', desc: '', args: []);
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
    return Intl.message('Reessayez', name: 'tryAgain', desc: '', args: []);
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

  /// `Entrez votre identifiant ou votre email`
  String get hintIdText {
    return Intl.message(
      'Entrez votre identifiant ou votre email',
      name: 'hintIdText',
      desc: '',
      args: [],
    );
  }

  /// `Identifiant/Email`
  String get labelIdText {
    return Intl.message(
      'Identifiant/Email',
      name: 'labelIdText',
      desc: '',
      args: [],
    );
  }

  /// `Entrez votre mot de passe`
  String get hintPasswordText {
    return Intl.message(
      'Entrez votre mot de passe',
      name: 'hintPasswordText',
      desc: '',
      args: [],
    );
  }

  /// `Mot de passe`
  String get labelPasswordText {
    return Intl.message(
      'Mot de passe',
      name: 'labelPasswordText',
      desc: '',
      args: [],
    );
  }

  /// `Echec de Connexion`
  String get loginFailed {
    return Intl.message(
      'Echec de Connexion',
      name: 'loginFailed',
      desc: '',
      args: [],
    );
  }

  /// `Connexion...`
  String get loggin {
    return Intl.message('Connexion...', name: 'loggin', desc: '', args: []);
  }

  /// `Un mail de reinitialisation vous a été envoyé`
  String get emailSend {
    return Intl.message(
      'Un mail de reinitialisation vous a été envoyé',
      name: 'emailSend',
      desc: '',
      args: [],
    );
  }

  /// `Erreur de mail. Reessayez!!!`
  String get emailNoSend {
    return Intl.message(
      'Erreur de mail. Reessayez!!!',
      name: 'emailNoSend',
      desc: '',
      args: [],
    );
  }

  /// `Connexion reussie`
  String get loginSuccess {
    return Intl.message(
      'Connexion reussie',
      name: 'loginSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Email Invalide`
  String get invalidMail {
    return Intl.message(
      'Email Invalide',
      name: 'invalidMail',
      desc: '',
      args: [],
    );
  }

  /// `Téléphone Invalide`
  String get invalidPhone {
    return Intl.message(
      'Téléphone Invalide',
      name: 'invalidPhone',
      desc: '',
      args: [],
    );
  }

  /// `Mot de Passe Invalide`
  String get invalidPass {
    return Intl.message(
      'Mot de Passe Invalide',
      name: 'invalidPass',
      desc: '',
      args: [],
    );
  }

  /// `Mot de Passe oublié ?`
  String get forgotPass {
    return Intl.message(
      'Mot de Passe oublié ?',
      name: 'forgotPass',
      desc: '',
      args: [],
    );
  }

  /// `Connexion`
  String get connexion {
    return Intl.message('Connexion', name: 'connexion', desc: '', args: []);
  }

  /// `Pas encore de Compte?  `
  String get noAccount {
    return Intl.message(
      'Pas encore de Compte?  ',
      name: 'noAccount',
      desc: '',
      args: [],
    );
  }

  /// `Mot de Passe`
  String get password {
    return Intl.message('Mot de Passe', name: 'password', desc: '', args: []);
  }

  /// `Création du compte...`
  String get registering {
    return Intl.message(
      'Création du compte...',
      name: 'registering',
      desc: '',
      args: [],
    );
  }

  /// `Création du compte reussie verifiez vos mails...`
  String get registerSuccess {
    return Intl.message(
      'Création du compte reussie verifiez vos mails...',
      name: 'registerSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Echec de création de compte`
  String get registerFailed {
    return Intl.message(
      'Echec de création de compte',
      name: 'registerFailed',
      desc: '',
      args: [],
    );
  }

  /// `Creer un compte`
  String get createAccount {
    return Intl.message(
      'Creer un compte',
      name: 'createAccount',
      desc: '',
      args: [],
    );
  }

  /// `Nom d'utilisateur`
  String get username {
    return Intl.message(
      'Nom d\'utilisateur',
      name: 'username',
      desc: '',
      args: [],
    );
  }

  /// `Mots de passes differents`
  String get passError {
    return Intl.message(
      'Mots de passes differents',
      name: 'passError',
      desc: '',
      args: [],
    );
  }

  /// `Confirmer le Mot de Passe`
  String get cpassword {
    return Intl.message(
      'Confirmer le Mot de Passe',
      name: 'cpassword',
      desc: '',
      args: [],
    );
  }

  /// `J'ai déja un compte`
  String get alreadyAccount {
    return Intl.message(
      'J\'ai déja un compte',
      name: 'alreadyAccount',
      desc: '',
      args: [],
    );
  }

  /// `CONNECTEZ VOUS`
  String get login {
    return Intl.message('CONNECTEZ VOUS', name: 'login', desc: '', args: []);
  }

  /// `Adresse Mail`
  String get email {
    return Intl.message('Adresse Mail', name: 'email', desc: '', args: []);
  }

  /// `Remplissez l'adresse mail`
  String get addEmail {
    return Intl.message(
      'Remplissez l\'adresse mail',
      name: 'addEmail',
      desc: '',
      args: [],
    );
  }

  /// `Numéro de Téléphone`
  String get phone {
    return Intl.message(
      'Numéro de Téléphone',
      name: 'phone',
      desc: '',
      args: [],
    );
  }

  /// `Envoyer un lien de reinitialisation`
  String get sendResetLink {
    return Intl.message(
      'Envoyer un lien de reinitialisation',
      name: 'sendResetLink',
      desc: '',
      args: [],
    );
  }

  /// `Reinitialiser le Mot de Passe`
  String get resetPassword {
    return Intl.message(
      'Reinitialiser le Mot de Passe',
      name: 'resetPassword',
      desc: '',
      args: [],
    );
  }

  /// `Téléphone ou Email Invalide`
  String get invalidId {
    return Intl.message(
      'Téléphone ou Email Invalide',
      name: 'invalidId',
      desc: '',
      args: [],
    );
  }

  /// `- OU -`
  String get or {
    return Intl.message('- OU -', name: 'or', desc: '', args: []);
  }

  /// `Se Connecter avec`
  String get signwith {
    return Intl.message(
      'Se Connecter avec',
      name: 'signwith',
      desc: '',
      args: [],
    );
  }

  /// `S'INSCRIRE`
  String get register {
    return Intl.message('S\'INSCRIRE', name: 'register', desc: '', args: []);
  }

  /// `Confirmer le Mot de Passe`
  String get confirmPassword {
    return Intl.message(
      'Confirmer le Mot de Passe',
      name: 'confirmPassword',
      desc: '',
      args: [],
    );
  }

  /// `Une erreur est survenue`
  String get error {
    return Intl.message(
      'Une erreur est survenue',
      name: 'error',
      desc: '',
      args: [],
    );
  }

  /// `reinitialisation effectuée`
  String get resetsuccess {
    return Intl.message(
      'reinitialisation effectuée',
      name: 'resetsuccess',
      desc: '',
      args: [],
    );
  }

  /// `Chargement...`
  String get loading {
    return Intl.message('Chargement...', name: 'loading', desc: '', args: []);
  }

  /// `Votre application est en cours de maintenance. Reessayez plus tard`
  String get maintenance {
    return Intl.message(
      'Votre application est en cours de maintenance. Reessayez plus tard',
      name: 'maintenance',
      desc: '',
      args: [],
    );
  }

  /// `Rechercher un établissement, un lieu...`
  String get search {
    return Intl.message(
      'Rechercher un établissement, un lieu...',
      name: 'search',
      desc: '',
      args: [],
    );
  }

  /// `Ouvert Maintenant : `
  String get opennow {
    return Intl.message(
      'Ouvert Maintenant : ',
      name: 'opennow',
      desc: '',
      args: [],
    );
  }

  /// `Fermé : `
  String get close {
    return Intl.message('Fermé : ', name: 'close', desc: '', args: []);
  }

  /// `Ouvert`
  String get open {
    return Intl.message('Ouvert', name: 'open', desc: '', args: []);
  }

  /// `Fermé`
  String get closed {
    return Intl.message('Fermé', name: 'closed', desc: '', args: []);
  }

  /// `Erreur de Chargement`
  String get searcherror {
    return Intl.message(
      'Erreur de Chargement',
      name: 'searcherror',
      desc: '',
      args: [],
    );
  }

  /// `Aucun resultat trouvé`
  String get searchnotfound {
    return Intl.message(
      'Aucun resultat trouvé',
      name: 'searchnotfound',
      desc: '',
      args: [],
    );
  }

  /// `Rechercher`
  String get hintSearch {
    return Intl.message('Rechercher', name: 'hintSearch', desc: '', args: []);
  }

  /// `Les mots de passe ne correspondent pas`
  String get passwordsDontMatch {
    return Intl.message(
      'Les mots de passe ne correspondent pas',
      name: 'passwordsDontMatch',
      desc: '',
      args: [],
    );
  }

  /// `réinitialisation du mot de passe`
  String get passwordReset {
    return Intl.message(
      'réinitialisation du mot de passe',
      name: 'passwordReset',
      desc: '',
      args: [],
    );
  }

  /// `Saisir l'e-mail pour réinitialiser`
  String get enterEmailForReset {
    return Intl.message(
      'Saisir l\'e-mail pour réinitialiser',
      name: 'enterEmailForReset',
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
