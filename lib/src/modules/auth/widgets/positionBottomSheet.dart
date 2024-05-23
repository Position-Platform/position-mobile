// ignore_for_file: must_be_immutable, file_names

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:position/src/core/utils/colors.dart';
import 'package:position/src/modules/app/bloc/app_bloc.dart';
import 'package:position/src/widgets/positionChooseLanguage.dart';

class PositionBottomSheet extends StatefulWidget {
  const PositionBottomSheet(
      {super.key, required this.appBloc, required this.textSize});
  final AppBloc appBloc;
  final double textSize;

  @override
  State<PositionBottomSheet> createState() => _PositionBottomSheetState();
}

class _PositionBottomSheetState extends State<PositionBottomSheet> {
  @override
  Widget build(BuildContext context) {
    final Locale appLocale = Localizations.localeOf(context);
    return Container(
      alignment: Alignment.center,
      width: MediaQuery.of(context).size.width,
      height: 64,
      decoration: const BoxDecoration(color: accentColor),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            width: 50,
          ),
          PositionChooseLanguage(
              appLocale: appLocale,
              textSize: widget.textSize,
              appBloc: widget.appBloc),
          Container(
            margin: const EdgeInsets.only(left: 50),
            child: SvgPicture.asset(
              "assets/images/svg/icon-help.svg",
              height: 20,
              width: 20,
            ),
          )
        ],
      ),
    );
  }
}
