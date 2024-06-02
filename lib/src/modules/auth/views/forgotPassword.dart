// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:position/generated/l10n.dart';
import 'package:position/src/core/utils/colors.dart';
import 'package:position/src/core/utils/tools.dart';
import 'package:position/src/modules/app/bloc/app_bloc.dart';
import 'package:position/src/modules/auth/blocs/login/login_bloc.dart';
import 'package:position/src/modules/auth/widgets/positionAuthHeader.dart';
import 'package:position/src/modules/auth/widgets/positionBottomSheet.dart';
import 'package:position/src/widgets/positionTextFormField.dart';
import 'package:position/src/widgets/positionValidateButton.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final TextEditingController _emailController = TextEditingController();

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
    super.dispose();
  }

  bool get isPopulated => _emailController.text.isNotEmpty;

  void _onForgotPasswordSubmitted() {
    if (isPopulated) {
      _loginBloc!.add(
        PasswordForgot(
          email: _emailController.text,
        ),
      );
    } else {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(PositionLocalizations.of(context).addEmail),
                const Icon(Icons.error)
              ],
            ),
            backgroundColor: redColor,
            duration: const Duration(seconds: 2),
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    changeStatusColor(Theme.of(context).colorScheme.background);
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SingleChildScrollView(
        child: BlocListener<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state.isSend!) {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    content: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(PositionLocalizations.of(context).emailSend),
                        const Icon(Icons.check_circle)
                      ],
                    ),
                    backgroundColor: primaryColor,
                    duration: const Duration(seconds: 5),
                  ),
                );

              Navigator.pop(context);
            }
            if (state.isFailSend!) {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    content: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(PositionLocalizations.of(context).emailNoSend),
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
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.background),
                    child: Column(
                      children: [
                        const PositionAuthHeader(),
                        const SizedBox(
                          height: 58,
                        ),
                        PositionTextFormField(
                            boxDecorationColor: grey97,
                            textController: _emailController,
                            hintText: PositionLocalizations.of(context).email,
                            labelText: PositionLocalizations.of(context).email,
                            suffixIcon: Icons.email,
                            suffixIconOnPressed: null,
                            keyboardType: TextInputType.emailAddress,
                            obscureText: false),
                        const SizedBox(
                          height: 60,
                        ),
                        PositionValideButton(
                            width: 220,
                            height: 35,
                            color: primaryColor,
                            textColor: whiteColor,
                            buttonText:
                                PositionLocalizations.of(context).sendResetLink,
                            onPressed: _onForgotPasswordSubmitted),
                      ],
                    ),
                  )
                ],
              );
            },
          ),
        ),
      ),
      bottomSheet: PositionBottomSheet(
        selectLanguage: (language) {
          if (language == "Français") {
            _appBloc?.add(const ChangeLanguage(Locale("fr", "FR")));
          } else {
            _appBloc?.add(const ChangeLanguage(Locale("en", "US")));
          }
        },
      ),
    );
  }
}
