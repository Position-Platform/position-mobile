// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:position/generated/l10n.dart';
import 'package:position/src/core/utils/colors.dart';
import 'package:position/src/core/utils/tools.dart';
import 'package:position/src/modules/app/bloc/app_bloc.dart';
import 'package:position/src/modules/auth/blocs/register/register_bloc.dart';
import 'package:position/src/modules/auth/widgets/positionAuthHeader.dart';
import 'package:position/src/modules/auth/widgets/positionBottomSheet.dart';
import 'package:position/src/widgets/positionTextFormField.dart';
import 'package:position/src/widgets/positionValidateButton.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _cpasswordController = TextEditingController();

  RegisterBloc? _registerBloc;
  AppBloc? _appBloc;

  bool get isPopulated =>
      _emailController.text.isNotEmpty &&
      _nameController.text.isNotEmpty &&
      _phoneController.text.isNotEmpty &&
      _passwordController.text.isNotEmpty;

  bool isRegisterButtonEnabled(RegisterState state) {
    return state.isFormValid && isPopulated && !state.isSubmitting!;
  }

  @override
  void initState() {
    super.initState();
    _registerBloc = BlocProvider.of<RegisterBloc>(context);
    _appBloc = BlocProvider.of<AppBloc>(context);
    _emailController.addListener(_onEmailChanged);
    _passwordController.addListener(_onPasswordChanged);
    _cpasswordController.addListener(_onCPasswordChanged);
    _phoneController.addListener(_onPhoneChanged);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    _cpasswordController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _onEmailChanged() {
    _registerBloc!.add(
      RegisterEmailChanged(email: _emailController.text),
    );
  }

  void _onPasswordChanged() {
    _registerBloc!.add(
      RegisterPasswordChanged(password: _passwordController.text),
    );
  }

  void _onCPasswordChanged() {
    _registerBloc!.add(
      RegisterCPasswordChanged(
          password: _passwordController.text,
          cpassword: _cpasswordController.text),
    );
  }

  void _onPhoneChanged() {
    _registerBloc!.add(
      RegisterPhoneChanged(phone: _phoneController.text),
    );
  }

  void _onFormSubmitted() {
    _registerBloc!.add(
      RegisterSubmitted(
          email: _emailController.text,
          password: _passwordController.text,
          name: _nameController.text,
          phone: _phoneController.text),
    );
  }

  @override
  Widget build(BuildContext context) {
    changeStatusColor(Theme.of(context).colorScheme.surface);
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SingleChildScrollView(
        child: BlocListener<RegisterBloc, RegisterState>(
          listener: (context, state) {
            if (state.isFailure!) {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    content: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(PositionLocalizations.of(context).registerFailed),
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
                        Text(PositionLocalizations.of(context).registering),
                        const CircularProgressIndicator(),
                      ],
                    ),
                  ),
                );
            }

            if (state.isSuccess!) {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    content: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(PositionLocalizations.of(context).registerSuccess),
                        const Icon(Icons.check_circle)
                      ],
                    ),
                    backgroundColor: primaryColor,
                    duration: const Duration(seconds: 10),
                  ),
                );
              Navigator.of(context).pop();
            }
          },
          child: BlocBuilder<RegisterBloc, RegisterState>(
            builder: (context, state) {
              return Stack(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surface),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const PositionAuthHeader(),
                        const SizedBox(
                          height: 50,
                        ),
                        PositionTextFormField(
                            boxDecorationColor: grey97,
                            textController: _nameController,
                            hintText:
                                PositionLocalizations.of(context).username,
                            labelText:
                                PositionLocalizations.of(context).username,
                            suffixIcon: Icons.person,
                            suffixIconOnPressed: null,
                            keyboardType: TextInputType.text,
                            obscureText: false),
                        const SizedBox(
                          height: 18,
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
                        !state.isEmailValid!
                            ? Text(
                                PositionLocalizations.of(context).invalidMail,
                                textAlign: TextAlign.left,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(color: redColor),
                              )
                            : const Text(""),
                        const SizedBox(
                          height: 18,
                        ),
                        PositionTextFormField(
                            boxDecorationColor: grey97,
                            textController: _phoneController,
                            hintText: PositionLocalizations.of(context).phone,
                            labelText: PositionLocalizations.of(context).phone,
                            suffixIcon: Icons.email,
                            suffixIconOnPressed: null,
                            keyboardType: TextInputType.phone,
                            obscureText: false),
                        !state.isPhoneValid!
                            ? Text(
                                PositionLocalizations.of(context).invalidPhone,
                                textAlign: TextAlign.left,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(color: redColor),
                              )
                            : const Text(""),
                        const SizedBox(
                          height: 18,
                        ),
                        PositionTextFormField(
                            boxDecorationColor: grey97,
                            textController: _passwordController,
                            hintText:
                                PositionLocalizations.of(context).password,
                            labelText:
                                PositionLocalizations.of(context).password,
                            suffixIcon: state.isPasswordVisible!
                                ? Icons.lock_open
                                : Icons.lock,
                            suffixIconOnPressed: () {
                              _registerBloc!.add(RegisterPasswordVisibility(
                                  passwordVisibility: state.isPasswordVisible!,
                                  cpasswordVisibility:
                                      state.isCPasswordVisible!));
                            },
                            keyboardType: TextInputType.text,
                            obscureText: !state.isPasswordVisible!),
                        !state.isPasswordValid!
                            ? Text(
                                PositionLocalizations.of(context).invalidPass,
                                textAlign: TextAlign.left,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(color: redColor),
                              )
                            : const Text(""),
                        const SizedBox(
                          height: 18,
                        ),
                        PositionTextFormField(
                            boxDecorationColor: grey97,
                            textController: _cpasswordController,
                            hintText: PositionLocalizations.of(context)
                                .confirmPassword,
                            labelText: PositionLocalizations.of(context)
                                .confirmPassword,
                            suffixIcon: state.isCPasswordVisible!
                                ? Icons.lock_open
                                : Icons.lock,
                            suffixIconOnPressed: () {
                              _registerBloc!.add(RegisterPasswordVisibility(
                                  passwordVisibility: state.isPasswordVisible!,
                                  cpasswordVisibility:
                                      state.isCPasswordVisible!));
                            },
                            keyboardType: TextInputType.text,
                            obscureText: !state.isCPasswordVisible!),
                        !state.isCPasswordValid!
                            ? Text(
                                PositionLocalizations.of(context).invalidPass,
                                textAlign: TextAlign.left,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(color: redColor),
                              )
                            : const Text(""),
                        const SizedBox(
                          height: 20,
                        ),
                        PositionValideButton(
                            width: 130,
                            height: 35,
                            color: isRegisterButtonEnabled(state)
                                ? primaryColor
                                : greyColor,
                            textColor: whiteColor,
                            buttonText:
                                PositionLocalizations.of(context).register,
                            onPressed: isRegisterButtonEnabled(state)
                                ? _onFormSubmitted
                                : null),
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
