// ignore_for_file: must_be_immutable, file_names

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:position/src/core/utils/colors.dart';
import 'package:position/src/widgets/positionChooseLanguage.dart';

class PositionBottomSheet extends StatelessWidget {
  const PositionBottomSheet({super.key, required this.selectLanguage});
  final Function(String language) selectLanguage;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: screenWidth,
      height: 64,
      decoration: const BoxDecoration(color: accentColor),
      child: SafeArea(
        // Pour éviter les problèmes avec les notches et boutons virtuels
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(flex: 1),
                PositionChooseLanguage(
                  selectLanguage: selectLanguage,
                ),
                Flexible(
                  flex: 1,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 24.0),
                      child: SvgPicture.asset(
                        "assets/images/svg/icon-help.svg",
                        height: 20,
                        width: 20,
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
