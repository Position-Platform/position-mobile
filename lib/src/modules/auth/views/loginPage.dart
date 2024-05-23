// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:position/generated/l10n.dart';
import 'package:position/src/core/di/di.dart';
import 'package:position/src/core/utils/colors.dart';
import 'package:position/src/core/utils/sizes.dart';
import 'package:position/src/core/utils/tools.dart';
import 'package:position/src/modules/app/bloc/app_bloc.dart';
import 'package:position/src/modules/auth/blocs/auth/auth_bloc.dart';
import 'package:position/src/modules/auth/blocs/login/login_bloc.dart';
import 'package:position/src/modules/auth/blocs/register/register_bloc.dart';
import 'package:position/src/modules/auth/models/setting_model/setting.dart';
import 'package:position/src/modules/auth/views/forgotPassword.dart';
import 'package:position/src/modules/auth/views/registerPage.dart';
import 'package:position/src/modules/auth/widgets/positionAuthHeader.dart';
import 'package:position/src/modules/auth/widgets/positionBottomSheet.dart';
import 'package:position/src/modules/auth/widgets/positionSocialAuthButtons.dart';
import 'package:position/src/widgets/positionTextFormField.dart';
import 'package:position/src/widgets/positionValidateButton.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, required this.setting});
  final Setting setting;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _identifiantController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  LoginBloc? _loginBloc;
  AppBloc? _appBloc;

  bool get isPopulated =>
      _identifiantController.text.isNotEmpty &&
      _passwordController.text.isNotEmpty;

  bool isLoginButtonEnabled(LoginState state) {
    return state.isFormValid && isPopulated && !state.isSubmitting!;
  }

  @override
  void initState() {
    super.initState();
    _loginBloc = BlocProvider.of<LoginBloc>(context);
    _appBloc = BlocProvider.of<AppBloc>(context);
    _identifiantController.addListener(_onLoginIdentifiantChanged);
    _passwordController.addListener(_onLoginPasswordChanged);
  }

  @override
  void dispose() {
    _identifiantController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onLoginIdentifiantChanged() {
    _loginBloc!.add(
      LoginIdChanged(identifiant: _identifiantController.text),
    );
  }

  void _onLoginPasswordChanged() {
    _loginBloc!.add(
      LoginPasswordChanged(password: _passwordController.text),
    );
  }

  void _onFormSubmitted() {
    _loginBloc!.add(
      LoginWithCredentialsPressed(
        identifiant: _identifiantController.text,
        password: _passwordController.text,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    changeStatusColor(whiteColor);
    return Scaffold(
      backgroundColor: whiteColor,
      body: SingleChildScrollView(
        child: BlocListener<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state.isFailure!) {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    content: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(PositionLocalizations.of(context).loginFailed),
                        const Icon(Icons.error)
                      ],
                    ),
                    backgroundColor: redColor,
                    duration: const Duration(seconds: 5),
                  ),
                );
            }
            if (state.isSubmitting!) {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    content: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(PositionLocalizations.of(context).loggin),
                        const CircularProgressIndicator(),
                      ],
                    ),
                  ),
                );
            }

            if (state.isSuccess!) {
              context.read<AuthBloc>().add(AuthLoggedIn());
            }
          },
          child: BlocBuilder<LoginBloc, LoginState>(
            builder: (context, state) {
              return Stack(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(color: whiteColor),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const PositionAuthHeader(),
                        const SizedBox(
                          height: 50,
                        ),
                        PositionTextFormField(
                            boxDecorationColor: grey97,
                            textController: _identifiantController,
                            textSize: textSize,
                            hintText:
                                PositionLocalizations.of(context).hintIdText,
                            labelText:
                                PositionLocalizations.of(context).labelIdText,
                            suffixIcon: Icons.person,
                            suffixIconOnPressed: null,
                            keyboardType: TextInputType.text,
                            obscureText: false),
                        !state.isIdValid!
                            ? Text(
                                PositionLocalizations.of(context).invalidId,
                                textAlign: TextAlign.left,
                                style: const TextStyle(
                                    color: redColor,
                                    fontSize: 11,
                                    fontFamily: "OpenSans"),
                              )
                            : const Text(""),
                        const SizedBox(
                          height: 20,
                        ),
                        PositionTextFormField(
                            boxDecorationColor: grey97,
                            textController: _passwordController,
                            textSize: textSize,
                            hintText: PositionLocalizations.of(context)
                                .hintPasswordText,
                            labelText: PositionLocalizations.of(context)
                                .labelPasswordText,
                            suffixIcon: state.isPasswordVisible!
                                ? Icons.lock_open
                                : Icons.lock,
                            keyboardType: TextInputType.text,
                            suffixIconOnPressed: () {
                              _loginBloc!.add(LoginPasswordVisibility(
                                  passwordVisibility: state.isPasswordVisible!,
                                  cpasswordVisibility: false));
                            },
                            obscureText: state.isPasswordVisible!),
                        !state.isPasswordValid!
                            ? Text(
                                PositionLocalizations.of(context).invalidPass,
                                textAlign: TextAlign.left,
                                style: const TextStyle(
                                    color: redColor,
                                    fontSize: 11,
                                    fontFamily: "OpenSans"),
                              )
                            : const Text(""),
                        const SizedBox(
                          height: 35,
                        ),
                        InkWell(
                          highlightColor: transparent,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return BlocProvider(
                                    create: (context) => _loginBloc!,
                                    child: const ForgotPassword(),
                                  );
                                },
                              ),
                            );
                          },
                          child: Container(
                            margin: const EdgeInsets.only(left: 50, right: 150),
                            child: Text(
                                PositionLocalizations.of(context).forgotPass,
                                style: TextStyle(
                                  fontFamily: 'OpenSans-Bold',
                                  color: primaryColor,
                                  fontSize: textSize,
                                  fontWeight: FontWeight.w700,
                                  fontStyle: FontStyle.normal,
                                )),
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            PositionValideButton(
                                width: 130,
                                height: 35,
                                color: whiteColor,
                                textColor: primaryColor,
                                buttonText: PositionLocalizations.of(context)
                                    .createAccount,
                                textSize: textSize,
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return BlocProvider(
                                          create: (context) =>
                                              getIt<RegisterBloc>(),
                                          child: const RegisterPage(),
                                        );
                                      },
                                    ),
                                  );
                                }),
                            const SizedBox(
                              width: 20,
                            ),
                            PositionValideButton(
                                width: 130,
                                height: 35,
                                color: isLoginButtonEnabled(state)
                                    ? primaryColor
                                    : greyColor,
                                textColor: whiteColor,
                                buttonText:
                                    PositionLocalizations.of(context).connexion,
                                textSize: textSize,
                                onPressed: isLoginButtonEnabled(state)
                                    ? _onFormSubmitted
                                    : null)
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        widget.setting.isFacebookLoginEnabled! ||
                                widget.setting.isGoogleLoginEnabled! ||
                                widget.setting.isOsmLoginEnabled!
                            ? Text(
                                PositionLocalizations.of(context).or,
                                style: const TextStyle(
                                  fontFamily: 'OpenSans-Bold',
                                  fontSize: 14,
                                  color: greyColor,
                                ),
                              )
                            : const SizedBox(),
                        const SizedBox(
                          height: 10,
                        ),
                        widget.setting.isFacebookLoginEnabled! ||
                                widget.setting.isGoogleLoginEnabled! ||
                                widget.setting.isOsmLoginEnabled!
                            ? Text(
                                PositionLocalizations.of(context).signwith,
                                style: const TextStyle(
                                  fontFamily: 'OpenSans',
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: greyColor,
                                ),
                              )
                            : const SizedBox(),
                        const SizedBox(
                          height: 20,
                        ),
                        PositionSocialAuthButtons(
                          setting: widget.setting,
                        ),
                        const SizedBox(
                          height: 80,
                        ),
                      ],
                    ),
                  )
                ],
              );
            },
          ),
        ),
      ),
      bottomSheet: PositionBottomSheet(appBloc: _appBloc!, textSize: textSize),
    );
  }
}
