part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

//authentification reussie
class AuthSuccess extends AuthState {
  final User user;
  final Setting settings;

  const AuthSuccess(this.user, this.settings);

  @override
  List<Object> get props => [user, settings];

  @override
  String toString() => 'AuthSuccess { User: $user, Settings: $settings}';
}

//Etat qui gère la premiere ouverture de l'application
class AuthFirstOpen extends AuthState {}

//Echec d'authentification
class AuthFailure extends AuthState {
  final Setting settings;

  const AuthFailure(this.settings);

  @override
  List<Object> get props => [settings];

  @override
  String toString() => 'AuthFailure { Settings: $settings}';
}

//Authetification Login
class AuthLoginState extends AuthState {}

//Authetification Register
class AuthRegisterState extends AuthState {}

//Pas de Connexion Internet
class AuthNoInternet extends AuthState {}

//Server Error
class AuthServerError extends AuthState {}

// Maintenance en cours
class AuthMaintenance extends AuthState {}
