// ignore_for_file: file_names

import 'package:flutter/material.dart';

class PositionMapFloatongActionButton extends StatelessWidget {
  const PositionMapFloatongActionButton({
    super.key,
    required this.buttonTag,
    required this.buttonPressed,
    required this.buttonIcon,
  });

  final String buttonTag;
  final VoidCallback buttonPressed;
  final Widget buttonIcon;

  @override
  Widget build(BuildContext context) {
    // Optimisation: utilisation de dimensions constantes
    const double buttonSize = 43;

    return SizedBox(
      width: buttonSize,
      height: buttonSize,
      child: FloatingActionButton(
        shape: const CircleBorder(),
        heroTag: buttonTag,
        tooltip: buttonTag,
        backgroundColor: Theme.of(context).colorScheme.surface,
        onPressed: buttonPressed,
        elevation:
            4.0, // Réduire l'élévation pour améliorer les performances de rendu
        child: buttonIcon,
      ),
    );
  }
}
