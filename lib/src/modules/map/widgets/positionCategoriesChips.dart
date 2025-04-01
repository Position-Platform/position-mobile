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

    // Précalculer le style de texte pour éviter les recalculs
    final textStyle = theme.textTheme.bodyMedium?.copyWith(
      fontFamily: "OpenSans-Bold",
      fontSize: 11,
    );

    // Précalculer le chemin de l'image
    final iconPath = "assets$icon";

    return InkWell(
      onTap: callback,
      highlightColor: transparent,
      child: Chip(
        labelPadding: const EdgeInsets.all(1.0),
        shape: StadiumBorder(
          side: BorderSide(
            color: theme.colorScheme.surface,
          ),
        ),
        avatar: CircleAvatar(
          backgroundColor: transparent,
          // Mise en cache du SvgPicture pour améliorer les performances
          child: SvgPicture.asset(
            iconPath,
            height: 15,
            width: 15,
          ),
        ),
        label: Text(
          label,
          style: textStyle,
        ),
        backgroundColor: theme.colorScheme.surface,
        elevation: 10.0,
        shadowColor: transparent,
        padding: const EdgeInsets.all(6.0),
      ),
    );
  }
}
