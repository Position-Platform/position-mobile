// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:position/generated/l10n.dart';
import 'package:position/src/core/di/di.dart';
import 'package:position/src/core/utils/colors.dart';
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
  final _formKey = GlobalKey<FormState>();

  late LoginBloc _loginBloc;
  late AppBloc _appBloc;

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
    _loginBloc.add(
      LoginIdChanged(identifiant: _identifiantController.text),
    );
  }

  void _onLoginPasswordChanged() {
    _loginBloc.add(
      LoginPasswordChanged(password: _passwordController.text),
    );
  }

  void _onFormSubmitted() {
    if (_formKey.currentState?.validate() ?? false) {
      _loginBloc.add(
        LoginWithCredentialsPressed(
          identifiant: _identifiantController.text,
          password: _passwordController.text,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isSmallScreen = screenSize.width < 360;
    final horizontalPadding = screenSize.width * 0.05;

    changeStatusColor(Theme.of(context).colorScheme.surface);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: BlocListener<LoginBloc, LoginState>(
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
                        child:
                            Text(PositionLocalizations.of(context).loginFailed),
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
                        child: Text(PositionLocalizations.of(context).loggin),
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
            context.read<AuthBloc>().add(AuthLoggedIn());
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
                            const SizedBox(
                              height: 50,
                            ),
                            PositionTextFormField(
                              boxDecorationColor: grey97,
                              textController: _identifiantController,
                              hintText:
                                  PositionLocalizations.of(context).hintIdText,
                              labelText:
                                  PositionLocalizations.of(context).labelIdText,
                              suffixIcon: Icons.person,
                              suffixIconOnPressed: null,
                              keyboardType: TextInputType.text,
                              obscureText: false,
                            ),
                            !state.isIdValid!
                                ? Padding(
                                    padding: const EdgeInsets.only(
                                        left: 24.0, top: 4.0),
                                    child: Text(
                                      PositionLocalizations.of(context)
                                          .invalidId,
                                      textAlign: TextAlign.left,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(color: redColor),
                                    ),
                                  )
                                : const SizedBox(height: 4),
                            const SizedBox(
                              height: 20,
                            ),
                            PositionTextFormField(
                              boxDecorationColor: grey97,
                              textController: _passwordController,
                              hintText: PositionLocalizations.of(context)
                                  .hintPasswordText,
                              labelText: PositionLocalizations.of(context)
                                  .labelPasswordText,
                              suffixIcon: state.isPasswordVisible!
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              keyboardType: TextInputType.text,
                              suffixIconOnPressed: () {
                                _loginBloc.add(LoginPasswordVisibility(
                                  passwordVisibility: state.isPasswordVisible!,
                                  cpasswordVisibility: false,
                                ));
                              },
                              obscureText: !state.isPasswordVisible!,
                            ),
                            !state.isPasswordValid!
                                ? Padding(
                                    padding: const EdgeInsets.only(
                                        left: 24.0, top: 4.0),
                                    child: Text(
                                      PositionLocalizations.of(context)
                                          .invalidPass,
                                      textAlign: TextAlign.left,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(color: redColor),
                                    ),
                                  )
                                : const SizedBox(height: 4),
                            const SizedBox(
                              height: 35,
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 20.0),
                                child: TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return BlocProvider(
                                            create: (context) =>
                                                getIt<LoginBloc>(),
                                            child: const ForgotPassword(),
                                          );
                                        },
                                      ),
                                    );
                                  },
                                  style: TextButton.styleFrom(
                                    padding: EdgeInsets.zero,
                                    minimumSize: const Size(44, 44),
                                    tapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
                                  ),
                                  child: Text(
                                    PositionLocalizations.of(context)
                                        .forgotPass,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                          fontFamily: "OpenSans-Bold",
                                          color: primaryColor,
                                          fontWeight: FontWeight.w700,
                                          fontStyle: FontStyle.normal,
                                        ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            isSmallScreen
                                ? Column(
                                    children: [
                                      PositionValideButton(
                                        width: double.infinity,
                                        height: 35,
                                        color: isLoginButtonEnabled(state)
                                            ? primaryColor
                                            : greyColor,
                                        textColor: whiteColor,
                                        buttonText:
                                            PositionLocalizations.of(context)
                                                .connexion,
                                        onPressed: isLoginButtonEnabled(state)
                                            ? _onFormSubmitted
                                            : null,
                                      ),
                                      const SizedBox(height: 16),
                                      PositionValideButton(
                                        width: double.infinity,
                                        height: 35,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .surface,
                                        textColor: primaryColor,
                                        buttonText:
                                            PositionLocalizations.of(context)
                                                .createAccount,
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
                                        },
                                      ),
                                    ],
                                  )
                                : Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: PositionValideButton(
                                          width: 130,
                                          height: 35,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .surface,
                                          textColor: primaryColor,
                                          buttonText:
                                              PositionLocalizations.of(context)
                                                  .createAccount,
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
                                          },
                                        ),
                                      ),
                                      const SizedBox(width: 20),
                                      Expanded(
                                        child: PositionValideButton(
                                          width: 130,
                                          height: 35,
                                          color: isLoginButtonEnabled(state)
                                              ? primaryColor
                                              : greyColor,
                                          textColor: whiteColor,
                                          buttonText:
                                              PositionLocalizations.of(context)
                                                  .connexion,
                                          onPressed: isLoginButtonEnabled(state)
                                              ? _onFormSubmitted
                                              : null,
                                        ),
                                      ),
                                    ],
                                  ),
                            const SizedBox(height: 20),
                            if (_shouldShowSocialLogin())
                              Column(
                                children: [
                                  Text(
                                    PositionLocalizations.of(context).or,
                                    style: const TextStyle(
                                      fontFamily: 'OpenSans-Bold',
                                      fontSize: 14,
                                      color: greyColor,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    PositionLocalizations.of(context).signwith,
                                    style: const TextStyle(
                                      fontFamily: 'OpenSans',
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: greyColor,
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  PositionSocialAuthButtons(
                                    setting: widget.setting,
                                    onLoginWithGooglePressed: () {
                                      _loginBloc.add(LoginWithGooglePressed());
                                    },
                                    onLoginWithApplePressed: () {
                                      _loginBloc.add(LoginWithApplePressed());
                                    },
                                    onLoginWithFacebookPressed: () {},
                                    onLoginWithOsmPressed: () {},
                                  ),
                                ],
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

  bool _shouldShowSocialLogin() {
    return widget.setting.isFacebookLoginEnabled! ||
        widget.setting.isGoogleLoginEnabled! ||
        widget.setting.isAppleLoginEnabled! ||
        widget.setting.isOsmLoginEnabled!;
  }
}
