// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:position/generated/l10n.dart';
import 'package:position/src/core/utils/colors.dart';
import 'package:position/src/core/utils/sizes.dart';
import 'package:position/src/core/utils/tools.dart';
import 'package:position/src/modules/app/bloc/app_bloc.dart';
import 'package:position/src/modules/auth/blocs/login/login_bloc.dart';
import 'package:position/src/modules/auth/widgets/positionAuthHeader.dart';
import 'package:position/src/modules/auth/widgets/positionBottomSheet.dart';
import 'package:position/src/widgets/positionTextFormField.dart';
import 'package:position/src/widgets/positionValidateButton.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _cpasswordController = TextEditingController();

  LoginBloc? _loginBloc;
  AppBloc? _appBloc;

  @override
  void initState() {
    super.initState();
    _loginBloc = BlocProvider.of<LoginBloc>(context);
    _appBloc = BlocProvider.of<AppBloc>(context);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _cpasswordController.dispose();
    super.dispose();
  }

  bool get isPopulated =>
      _emailController.text.isNotEmpty &&
      _passwordController.text.isNotEmpty &&
      _cpasswordController.text.isNotEmpty;

  void _onResetPasswordSubmitted() {
    if (!isPopulated) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(PositionLocalizations.of(context).error),
                const Icon(Icons.error)
              ],
            ),
            backgroundColor: redColor,
          ),
        );
      return;
    }
    _loginBloc!.add(
      PasswordReset(
          email: _emailController.text,
          password: _passwordController.text,
          resettoken: "widget.token!"),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    changeStatusColor(whiteColor);
    return Scaffold(
      backgroundColor: whiteColor,
      body: SingleChildScrollView(
        child: BlocListener<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state.isResetPassword!) {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    content: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(PositionLocalizations.of(context).resetsuccess),
                        const Icon(Icons.check_circle)
                      ],
                    ),
                    backgroundColor: primaryColor,
                    duration: const Duration(seconds: 2),
                  ),
                );
            }
            if (state.isFailedResetPassword!) {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    content: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(PositionLocalizations.of(context).error),
                        const Icon(Icons.error)
                      ],
                    ),
                    backgroundColor: redColor,
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
                        Text(PositionLocalizations.of(context).loading),
                        const CircularProgressIndicator(),
                      ],
                    ),
                  ),
                );
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
                      children: [
                        const PositionAuthHeader(),
                        const SizedBox(
                          height: 58,
                        ),
                        PositionTextFormField(
                            boxDecorationColor: grey97,
                            textController: _emailController,
                            textSize: textSize,
                            hintText: PositionLocalizations.of(context).email,
                            labelText: PositionLocalizations.of(context).email,
                            suffixIcon: Icons.email,
                            suffixIconOnPressed: null,
                            keyboardType: TextInputType.emailAddress,
                            obscureText: false),
                        const SizedBox(
                          height: 28,
                        ),
                        PositionTextFormField(
                            boxDecorationColor: grey97,
                            textController: _passwordController,
                            textSize: textSize,
                            hintText:
                                PositionLocalizations.of(context).password,
                            labelText:
                                PositionLocalizations.of(context).password,
                            suffixIcon: state.isPasswordVisible!
                                ? Icons.lock_open
                                : Icons.lock,
                            suffixIconOnPressed: () {
                              _loginBloc!.add(LoginPasswordVisibility(
                                  passwordVisibility: state.isPasswordVisible!,
                                  cpasswordVisibility:
                                      state.isCPasswordVisible!));
                            },
                            keyboardType: TextInputType.text,
                            obscureText: !state.isPasswordVisible!),
                        const SizedBox(
                          height: 28,
                        ),
                        PositionTextFormField(
                            boxDecorationColor: grey97,
                            textController: _cpasswordController,
                            textSize: textSize,
                            hintText: PositionLocalizations.of(context)
                                .confirmPassword,
                            labelText: PositionLocalizations.of(context)
                                .confirmPassword,
                            suffixIcon: state.isCPasswordVisible!
                                ? Icons.lock_open
                                : Icons.lock,
                            suffixIconOnPressed: () {
                              _loginBloc!.add(LoginPasswordVisibility(
                                  passwordVisibility: state.isPasswordVisible!,
                                  cpasswordVisibility:
                                      state.isCPasswordVisible!));
                            },
                            keyboardType: TextInputType.text,
                            obscureText: !state.isCPasswordVisible!),
                        const SizedBox(
                          height: 40,
                        ),
                        PositionValideButton(
                            width: 130,
                            height: 35,
                            color: primaryColor,
                            textColor: whiteColor,
                            buttonText:
                                PositionLocalizations.of(context).resetPassword,
                            textSize: textSize,
                            onPressed: _onResetPasswordSubmitted),
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
