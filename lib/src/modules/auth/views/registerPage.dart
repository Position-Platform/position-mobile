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
  final _formKey = GlobalKey<FormState>();

  late RegisterBloc _registerBloc;
  late AppBloc _appBloc;

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
    _registerBloc.add(
      RegisterEmailChanged(email: _emailController.text),
    );
  }

  void _onPasswordChanged() {
    _registerBloc.add(
      RegisterPasswordChanged(password: _passwordController.text),
    );
  }

  void _onCPasswordChanged() {
    _registerBloc.add(
      RegisterCPasswordChanged(
          password: _passwordController.text,
          cpassword: _cpasswordController.text),
    );
  }

  void _onPhoneChanged() {
    _registerBloc.add(
      RegisterPhoneChanged(phone: _phoneController.text),
    );
  }

  void _onFormSubmitted() {
    if (_formKey.currentState?.validate() ?? false) {
      _registerBloc.add(
        RegisterSubmitted(
            email: _emailController.text,
            password: _passwordController.text,
            name: _nameController.text,
            phone: _phoneController.text),
      );
    }
  }

  void _togglePasswordVisibility(
      bool isPasswordVisible, bool isCPasswordVisible) {
    _registerBloc.add(RegisterPasswordVisibility(
      passwordVisibility: isPasswordVisible,
      cpasswordVisibility: isCPasswordVisible,
    ));
  }

  Widget _buildErrorMessage(BuildContext context, String message) {
    return Padding(
      padding: const EdgeInsets.only(left: 24.0, top: 4.0),
      child: Text(
        message,
        textAlign: TextAlign.left,
        style:
            Theme.of(context).textTheme.bodyMedium?.copyWith(color: redColor),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final horizontalPadding = screenSize.width * 0.05;

    changeStatusColor(Theme.of(context).colorScheme.surface);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: BlocListener<RegisterBloc, RegisterState>(
        listener: (context, state) {
          if (state.isFailure!) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                            PositionLocalizations.of(context).registerFailed),
                      ),
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
                      Expanded(
                        child:
                            Text(PositionLocalizations.of(context).registering),
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

          if (state.isSuccess!) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                            PositionLocalizations.of(context).registerSuccess),
                      ),
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
                            const SizedBox(height: 50),
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
                              obscureText: false,
                            ),
                            const SizedBox(height: 18),
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
                            !state.isEmailValid!
                                ? _buildErrorMessage(
                                    context,
                                    PositionLocalizations.of(context)
                                        .invalidMail)
                                : const SizedBox(height: 4),
                            const SizedBox(height: 18),
                            PositionTextFormField(
                              boxDecorationColor: grey97,
                              textController: _phoneController,
                              hintText: PositionLocalizations.of(context).phone,
                              labelText:
                                  PositionLocalizations.of(context).phone,
                              suffixIcon: Icons.phone,
                              suffixIconOnPressed: null,
                              keyboardType: TextInputType.phone,
                              obscureText: false,
                            ),
                            !state.isPhoneValid!
                                ? _buildErrorMessage(
                                    context,
                                    PositionLocalizations.of(context)
                                        .invalidPhone)
                                : const SizedBox(height: 4),
                            const SizedBox(height: 18),
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
                            !state.isPasswordValid!
                                ? _buildErrorMessage(
                                    context,
                                    PositionLocalizations.of(context)
                                        .invalidPass)
                                : const SizedBox(height: 4),
                            const SizedBox(height: 18),
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
                            !state.isCPasswordValid!
                                ? _buildErrorMessage(
                                    context,
                                    PositionLocalizations.of(context)
                                        .invalidPass)
                                : const SizedBox(height: 4),
                            const SizedBox(height: 40),
                            PositionValideButton(
                              width: screenSize.width * 0.5,
                              height: 35,
                              color: isRegisterButtonEnabled(state)
                                  ? primaryColor
                                  : greyColor,
                              textColor: whiteColor,
                              buttonText:
                                  PositionLocalizations.of(context).register,
                              onPressed: isRegisterButtonEnabled(state)
                                  ? _onFormSubmitted
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
