// ignore_for_file: must_be_immutable, file_names

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:position/src/core/utils/colors.dart';
import 'package:position/src/widgets/positionChooseLanguage.dart';

class PositionBottomSheet extends StatefulWidget {
  const PositionBottomSheet({super.key, required this.selectLanguage});
  final Function(String language) selectLanguage;

  @override
  State<PositionBottomSheet> createState() => _PositionBottomSheetState();
}

class _PositionBottomSheetState extends State<PositionBottomSheet> {
  @override
  Widget build(BuildContext context) {
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
          PositionChooseLanguage(selectLanguage: (language) {
            widget.selectLanguage(language);
          }),
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
