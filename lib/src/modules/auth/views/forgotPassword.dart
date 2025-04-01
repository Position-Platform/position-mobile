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
  final _formKey = GlobalKey<FormState>();

  late LoginBloc _loginBloc;
  late AppBloc _appBloc;

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
      _loginBloc.add(
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
                Expanded(
                    child: Text(PositionLocalizations.of(context).addEmail)),
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
    final screenSize = MediaQuery.of(context).size;
    final horizontalPadding = screenSize.width * 0.05;

    changeStatusColor(Theme.of(context).colorScheme.surface);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state.isSend!) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          child: Text(
                              PositionLocalizations.of(context).emailSend)),
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
                      Expanded(
                          child: Text(
                              PositionLocalizations.of(context).emailNoSend)),
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
                      Expanded(
                          child:
                              Text(PositionLocalizations.of(context).loading)),
                      const SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(
                          strokeWidth: 3,
                        ),
                      ),
                    ],
                  ),
                ),
              );
          }
        },
        child: BlocBuilder<LoginBloc, LoginState>(
          builder: (context, state) {
            return GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: SingleChildScrollView(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: horizontalPadding),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const PositionAuthHeader(),
                            const SizedBox(height: 58),
                            Text(
                              PositionLocalizations.of(context).passwordReset,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 20),
                            Text(
                              PositionLocalizations.of(context)
                                  .enterEmailForReset,
                              style: Theme.of(context).textTheme.bodyMedium,
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 30),
                            PositionTextFormField(
                              boxDecorationColor: grey97,
                              textController: _emailController,
                              hintText: PositionLocalizations.of(context).email,
                              labelText:
                                  PositionLocalizations.of(context).email,
                              suffixIcon: Icons.email,
                              suffixIconOnPressed: null,
                              keyboardType: TextInputType.emailAddress,
                              obscureText: false,
                            ),
                            const SizedBox(height: 60),
                            PositionValideButton(
                              width: screenSize.width > 400
                                  ? 220
                                  : screenSize.width * 0.6,
                              height: 35,
                              color: isPopulated ? primaryColor : greyColor,
                              textColor: whiteColor,
                              buttonText: PositionLocalizations.of(context)
                                  .sendResetLink,
                              onPressed: isPopulated
                                  ? _onForgotPasswordSubmitted
                                  : null,
                            ),
                            const SizedBox(height: 80),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            );
          },
        ),
      ),
      bottomSheet: PositionBottomSheet(
        selectLanguage: (language) {
          if (language == "Français") {
            _appBloc.add(const ChangeLanguage(Locale("fr", "FR")));
          } else {
            _appBloc.add(const ChangeLanguage(Locale("en", "US")));
          }
        },
      ),
    );
  }
}
