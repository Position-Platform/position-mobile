import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:position/src/core/helpers/sharedpreferences.dart';
import 'package:position/src/core/services/log.service.dart';
import 'package:position/src/core/utils/result.dart';
import 'package:position/src/core/utils/validators.dart';
import 'package:position/src/modules/auth/models/auth_model/auth_model.dart';
import 'package:position/src/modules/auth/repositories/auth/authRepository.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository? authRepository;
  final SharedPreferencesHelper? sharedPreferencesHelper;
  final LogService logger;
  LoginBloc({
    this.authRepository,
    this.sharedPreferencesHelper,
    required this.logger,
  }) : super(LoginState.initial()) {
    on<LoginIdChanged>(_loginIdChanged,
        transformer: debounce(const Duration(milliseconds: 300)));
    on<LoginPasswordChanged>(_loginPasswordChanged,
        transformer: debounce(const Duration(milliseconds: 300)));
    on<LoginWithCredentialsPressed>(_loginButtonPressed);
    on<PasswordForgot>(_forgotButtonPressed);
    on<PasswordReset>(_resetButtonPressed);
    on<LoginPasswordVisibility>(_togglePasswordVisibility);
    on<LoginWithGooglePressed>(_googleButtonPressed);
    on<LoginWithApplePressed>(_appleButtonPressed);
  }

  // RxDart pour gerer les evenements de facon asynchrone
  EventTransformer<LoginEvent> debounce<LoginEvent>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }

  // Action de validation d'email qui s'effectue a chaque saisie de l'utilisateur
  void _loginIdChanged(
    LoginIdChanged event,
    Emitter<LoginState> emit,
  ) async {
    //loguer l'identifiant
    logger.info("LoginIdChanged: ${event.identifiant}");
    if (event.identifiant!.contains('@')) {
      return emit(
          state.update(isIdValid: Validators.isValidEmail(event.identifiant!)));
    } else {
      return emit(state.update(
          isIdValid: Validators.isValidTelephone(event.identifiant!)));
    }
  }

  // Action de validation de mot de passe qui s'effectue a chaque saisie de l'utilisateur
  void _loginPasswordChanged(
    LoginPasswordChanged event,
    Emitter<LoginState> emit,
  ) async {
    return emit(state.update(
      isPasswordValid: Validators.isValidPassword(event.password!),
    ));
  }

  // Methode qui s'execute lors du clic sur le boutton connexion
  void _loginButtonPressed(
    LoginWithCredentialsPressed event,
    Emitter<LoginState> emit,
  ) async {
    emit(LoginState.loading());
    try {
      //loguer l'identifiant et le mot de passe
      logger.info(
          "LoginWithCredentialsPressed: ${event.identifiant}, ${event.password}");
      Result<AuthModel> user = await authRepository!.login(
        event.identifiant!,
        event.password!,
      );
      if (user.success!.success!) {
        //loguer le token
        logger.info("Login success with token: ${user.success!.data!.token}");
        await sharedPreferencesHelper!.setToken(user.success!.data!.token!);
        //loguer les parametres de l'utilisateur
        logger.info("User data: ${user.success}");
        return emit(LoginState.success());
      } else {
        //loguer l'erreur
        logger.error("Login failed: ${user.success!.message}");
        return emit(LoginState.failure());
      }
    } catch (e) {
      //loguer l'erreur
      logger.error("Login error: $e");
      return emit(LoginState.failure());
    }
  }

  void _forgotButtonPressed(
    PasswordForgot event,
    Emitter<LoginState> emit,
  ) async {
    emit(LoginState.loading());
    try {
      //loguer l'email
      logger.info("PasswordForgot: ${event.email}");
      await authRepository!.forgotpassword(event.email!);
      //loguer le message de reussite
      logger.info("Password reset email sent to: ${event.email}");
      return emit(LoginState.send());
    } catch (_) {
      return emit(LoginState.failSend());
    }
  }

  void _resetButtonPressed(
    PasswordReset event,
    Emitter<LoginState> emit,
  ) async {
    emit(LoginState.loading());
    try {
      //loguer le mot de passe et le token
      logger.info(
          "PasswordReset: ${event.password}, ${event.resettoken}, ${event.email}");
      await authRepository!
          .resetpassword(event.email!, event.password!, event.resettoken!);
      //loguer le message de reussite
      logger.info("Password reset success for: ${event.email}");
      return emit(LoginState.resetPassword());
    } catch (e) {
      //loguer l'erreur
      logger.error("Password reset error: $e");
      return emit(LoginState.failedresetPassword());
    }
  }

  void _togglePasswordVisibility(
    LoginPasswordVisibility event,
    Emitter<LoginState> emit,
  ) async {
    emit(state.update(
        isPasswordVisible: !state.isPasswordVisible!,
        isCPasswordVisible: !state.isCPasswordVisible!));
  }

  void _googleButtonPressed(
    LoginWithGooglePressed event,
    Emitter<LoginState> emit,
  ) async {
    emit(LoginState.loading());
    try {
      var googleLogin = GoogleSignIn(
        scopes: ['email'],
      );

      //loguer l'utilisateur
      logger.info("Google login initiated");

      final result = await googleLogin.signIn();

      logger.info("Google login result: $result");

      if (result != null) {
        final authentication = await result.authentication;

        Result<AuthModel> auth =
            await authRepository!.registergoogle(authentication.accessToken!);
        logger.info("Google login auth result: ${auth.success}");
        if (auth.success!.success!) {
          //loguer le token
          logger.info(
              "Google login success with token: ${auth.success!.data!.token}");
          await sharedPreferencesHelper!.setToken(auth.success!.data!.token!);
          emit(LoginState.success());
        } else {
          //loguer l'erreur
          logger.error("Google login failed: ${auth.success!.message}");
          emit(LoginState.failure());
        }
      } else {
        //loguer l'erreur
        logger.error("Google login cancelled or failed");
        emit(LoginState.failure());
      }
    } catch (e) {
      //loguer l'erreur
      logger.error("Google login error: $e");
      emit(LoginState.failure());
    }
  }

  void _appleButtonPressed(
    LoginWithApplePressed event,
    Emitter<LoginState> emit,
  ) async {
    emit(LoginState.loading());
    try {
      var appleSigning = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      //loguer l'utilisateur
      logger.info("Apple login initiated");

      final result = appleSigning.authorizationCode;

      logger.info("Apple login result: $result");

      Result<AuthModel> auth = await authRepository!.registerapple(result);
      logger.info("Apple login auth result: ${auth.success}");
      if (auth.success!.success!) {
        //loguer le token
        logger.info(
            "Apple login success with token: ${auth.success!.data!.token}");
        await sharedPreferencesHelper!.setToken(auth.success!.data!.token!);
        //loguer les parametres de l'utilisateur
        logger.info("User data: ${auth.success}");
        emit(LoginState.success());
      } else {
        logger.error("Apple login failed: ${auth.success!.message}");
        emit(LoginState.failure());
      }
    } catch (e) {
      //loguer l'erreur
      logger.error("Apple login error: $e");
      emit(LoginState.failure());
    }
  }
}
