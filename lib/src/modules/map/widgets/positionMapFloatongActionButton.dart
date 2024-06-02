// ignore_for_file: file_names

import 'package:flutter/material.dart';

class PositionMapFloatongActionButton extends StatefulWidget {
  const PositionMapFloatongActionButton(
      {super.key,
      required this.buttonTag,
      required this.buttonPressed,
      required this.buttonIcon});

  final String buttonTag;
  final VoidCallback buttonPressed;
  final Widget buttonIcon;

  @override
  State<PositionMapFloatongActionButton> createState() =>
      _PositionMapFloatongActionButtonState();
}

class _PositionMapFloatongActionButtonState
    extends State<PositionMapFloatongActionButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 43,
      height: 43,
      child: FittedBox(
        child: FloatingActionButton(
          shape: const CircleBorder(),
          heroTag: widget.buttonTag,
          tooltip: widget.buttonTag,
          backgroundColor: Theme.of(context).colorScheme.background,
          onPressed: widget.buttonPressed,
          child: widget.buttonIcon,
        ),
      ),
    );
  }
}
