import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:position/src/core/helpers/sharedpreferences.dart';
import 'package:position/src/core/services/log.service.dart';
import 'package:position/src/core/utils/result.dart';
import 'package:position/src/core/utils/validators.dart';
import 'package:position/src/modules/auth/models/auth_model/auth_model.dart';
import 'package:position/src/modules/auth/repositories/auth/authRepository.dart';
import 'package:rxdart/rxdart.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final AuthRepository? authRepository;
  final SharedPreferencesHelper? sharedPreferencesHelper;
  final LogService logger;
  RegisterBloc({
    this.authRepository,
    this.sharedPreferencesHelper,
    required this.logger,
  }) : super(RegisterState.initial()) {
    // Définition des événements et de leurs gestionnaires
    on<RegisterEmailChanged>(_registerEmailChanged,
        transformer: debounce(const Duration(milliseconds: 300)));
    on<RegisterPasswordChanged>(_registerPasswordChanged,
        transformer: debounce(const Duration(milliseconds: 300)));
    on<RegisterCPasswordChanged>(_registerConfirmPasswordChanged,
        transformer: debounce(const Duration(milliseconds: 300)));
    on<RegisterPhoneChanged>(_registerPhoneChanged,
        transformer: debounce(const Duration(milliseconds: 300)));
    on<RegisterSubmitted>(_registerButtonPressed);
    on<RegisterPasswordVisibility>(_togglePasswordVisibility);
  }

  // RxDart pour gerer les evenements de facon asynchrone
  EventTransformer<RegisterEvent> debounce<RegisterEvent>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }

  // Action de validation d'email qui s'effectue a chaque saisie de l'utilisateur
  void _registerEmailChanged(
    RegisterEmailChanged event,
    Emitter<RegisterState> emit,
  ) async {
    return emit(state.update(
      isEmailValid: Validators.isValidEmail(event.email!),
    ));
  }

  // Action de validation de mot de passe qui s'effectue a chaque saisie de l'utilisateur
  void _registerPasswordChanged(
    RegisterPasswordChanged event,
    Emitter<RegisterState> emit,
  ) async {
    return emit(state.update(
      isPasswordValid: Validators.isValidPassword(event.password!),
    ));
  }

  // Action de confirmation de mot de passe qui s'effectue a chaque saisie de l'utilisateur
  void _registerConfirmPasswordChanged(
    RegisterCPasswordChanged event,
    Emitter<RegisterState> emit,
  ) async {
    return emit(state.update(
      isPasswordValid:
          Validators.isValidCPassword(event.password!, event.cpassword!),
    ));
  }

  // Action de validation de numéro de téléphone qui s'effectue a chaque saisie de l'utilisateur
  void _registerPhoneChanged(
    RegisterPhoneChanged event,
    Emitter<RegisterState> emit,
  ) async {
    return emit(state.update(
      isPhoneValid: Validators.isValidTelephone(event.phone!),
    ));
  }

  // Methode qui s'execute lors du clic sur le boutton connexion
  void _registerButtonPressed(
    RegisterSubmitted event,
    Emitter<RegisterState> emit,
  ) async {
    emit(RegisterState.loading());
    try {
      //loguer l'identifiant et le mot de passe
      logger.info(
          "RegisterWithCredentialsPressed: ${event.name}, ${event.email}, ${event.phone}, ${event.password}");
      // Appel de la méthode de registration du repository
      Result<AuthModel> user = await authRepository!
          .register(event.name!, event.email!, event.phone!, event.password!);
      //loguer le token
      logger.info("Register success with token: ${user.success!.data!.token}");
      if (user.success != null) {
        //loguer les parametres de l'utilisateur
        logger.info("User data: ${user.success}");
        return emit(RegisterState.success());
      } else {
        //loguer l'erreur
        logger.error("Register failed: ${user.success!.message}");
        return emit(RegisterState.failure());
      }
    } catch (error) {
      //loguer l'erreur
      logger.error("Register error: $error");
      return emit(RegisterState.failure());
    }
  }

  void _togglePasswordVisibility(
    RegisterPasswordVisibility event,
    Emitter<RegisterState> emit,
  ) async {
    emit(state.update(
        isPasswordVisible: !state.isPasswordVisible!,
        isCPasswordVisible: !state.isCPasswordVisible!));
  }
}
