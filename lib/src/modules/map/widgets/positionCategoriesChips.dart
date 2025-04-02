// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:position/src/core/utils/colors.dart';

class PositionCategorieChips extends StatelessWidget {
  const PositionCategorieChips({
    super.key,
    required this.callback,
    required this.label,
    required this.icon,
  });

  final VoidCallback callback;
  final String label;
  final String icon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textStyle = theme.textTheme.bodyMedium?.copyWith(
      fontFamily: "OpenSans-Bold",
      fontSize: 12,
    );
    final iconPath = "assets$icon";

    // Utiliser un Container avec BoxShadow personnalisé au lieu de Card
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(40),
            blurRadius: 4.0,
            spreadRadius: 0.0,
            offset: const Offset(0, 2), // Ombre légèrement décalée vers le bas
          ),
        ],
      ),
      child: Material(
        color: transparent,
        borderRadius: BorderRadius.circular(20.0),
        child: InkWell(
          onTap: callback,
          highlightColor: transparent,
          borderRadius: BorderRadius.circular(20.0),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(
                  iconPath,
                  height: 16,
                  width: 16,
                ),
                const SizedBox(width: 4),
                Text(
                  label,
                  style: textStyle,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
