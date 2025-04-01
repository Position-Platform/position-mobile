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

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _cpasswordController = TextEditingController();
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
    _passwordController.dispose();
    _cpasswordController.dispose();
    super.dispose();
  }

  bool get isPopulated =>
      _emailController.text.isNotEmpty &&
      _passwordController.text.isNotEmpty &&
      _cpasswordController.text.isNotEmpty;

  bool get _passwordsMatch =>
      _passwordController.text == _cpasswordController.text;

  void _onResetPasswordSubmitted() {
    if (!isPopulated) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(PositionLocalizations.of(context).error),
                ),
                const Icon(Icons.error)
              ],
            ),
            backgroundColor: redColor,
          ),
        );
      return;
    }

    if (!_passwordsMatch) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                      PositionLocalizations.of(context).passwordsDontMatch),
                ),
                const Icon(Icons.error)
              ],
            ),
            backgroundColor: redColor,
          ),
        );
      return;
    }

    _loginBloc.add(
      PasswordReset(
          email: _emailController.text,
          password: _passwordController.text,
          resettoken: "widget.token!"),
    );
    Navigator.pop(context);
  }

  void _togglePasswordVisibility(
      bool isPasswordVisible, bool isCPasswordVisible) {
    _loginBloc.add(LoginPasswordVisibility(
      passwordVisibility: isPasswordVisible,
      cpasswordVisibility: isCPasswordVisible,
    ));
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
          if (state.isResetPassword!) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                            PositionLocalizations.of(context).resetsuccess),
                      ),
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
                      Expanded(
                        child: Text(PositionLocalizations.of(context).error),
                      ),
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
                        child: Text(PositionLocalizations.of(context).loading),
                      ),
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
                            const SizedBox(height: 28),
                            PositionTextFormField(
                              boxDecorationColor: grey97,
                              textController: _passwordController,
                              hintText:
                                  PositionLocalizations.of(context).password,
                              labelText:
                                  PositionLocalizations.of(context).password,
                              suffixIcon: state.isPasswordVisible!
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              suffixIconOnPressed: () {
                                _togglePasswordVisibility(
                                    !state.isPasswordVisible!,
                                    state.isCPasswordVisible!);
                              },
                              keyboardType: TextInputType.text,
                              obscureText: !state.isPasswordVisible!,
                            ),
                            const SizedBox(height: 28),
                            PositionTextFormField(
                              boxDecorationColor: grey97,
                              textController: _cpasswordController,
                              hintText: PositionLocalizations.of(context)
                                  .confirmPassword,
                              labelText: PositionLocalizations.of(context)
                                  .confirmPassword,
                              suffixIcon: state.isCPasswordVisible!
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              suffixIconOnPressed: () {
                                _togglePasswordVisibility(
                                    state.isPasswordVisible!,
                                    !state.isCPasswordVisible!);
                              },
                              keyboardType: TextInputType.text,
                              obscureText: !state.isCPasswordVisible!,
                            ),
                            const SizedBox(height: 40),
                            PositionValideButton(
                              width: screenSize.width * 0.5,
                              height: 35,
                              color: isPopulated ? primaryColor : greyColor,
                              textColor: whiteColor,
                              buttonText: PositionLocalizations.of(context)
                                  .resetPassword,
                              onPressed: isPopulated
                                  ? _onResetPasswordSubmitted
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
