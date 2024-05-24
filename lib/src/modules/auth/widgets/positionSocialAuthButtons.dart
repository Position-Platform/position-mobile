// ignore_for_file: file_names

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:position/src/modules/auth/blocs/login/login_bloc.dart';
import 'package:position/src/modules/auth/models/setting_model/setting.dart';

class PositionSocialAuthButtons extends StatefulWidget {
  const PositionSocialAuthButtons(
      {super.key, required this.setting, required this.loginBloc});
  final Setting setting;
  final LoginBloc loginBloc;

  @override
  State<PositionSocialAuthButtons> createState() =>
      _PositionSocialAuthButtonsState();
}

class _PositionSocialAuthButtonsState extends State<PositionSocialAuthButtons> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Platform.isAndroid && widget.setting.isGoogleLoginEnabled!
            ? _buildLogoButton(
                image: 'assets/images/png/google_logo.png',
                onPressed: () {
                  widget.loginBloc.add(LoginWithGooglePressed());
                },
                tag: "google")
            : const SizedBox(),
        Platform.isIOS && widget.setting.isAppleLoginEnabled!
            ? _buildLogoButton(
                image: 'assets/images/png/apple.png',
                onPressed: () {
                  widget.loginBloc.add(LoginWithApplePressed());
                },
                tag: "apple")
            : const SizedBox(),
        const SizedBox(
          width: 20,
        ),
        widget.setting.isFacebookLoginEnabled!
            ? _buildLogoButton(
                image: 'assets/images/png/facebook_logo.png',
                onPressed: () {},
                tag: "facebook")
            : const SizedBox(),
        const SizedBox(
          width: 20,
        ),
        widget.setting.isOsmLoginEnabled!
            ? _buildLogoButton(
                image: 'assets/images/png/osm.png',
                onPressed: () {},
                tag: "openstreetmap")
            : const SizedBox(),
      ],
    );
  }

  Widget _buildLogoButton({
    required String image,
    required VoidCallback onPressed,
    required String tag,
  }) {
    return FloatingActionButton(
      heroTag: tag,
      backgroundColor: Colors.white,
      onPressed: onPressed,
      child: SizedBox(
        height: 30,
        child: Image.asset(image),
      ),
    );
  }
}
