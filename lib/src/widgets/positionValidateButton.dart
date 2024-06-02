// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:position/src/core/utils/colors.dart';

class PositionValideButton extends StatefulWidget {
  const PositionValideButton({
    super.key,
    required this.width,
    required this.height,
    required this.color,
    required this.buttonText,
    required this.onPressed,
    required this.textColor,
  });
  final double width;
  final double height;
  final Color color;
  final Color textColor;
  final String buttonText;
  final VoidCallback? onPressed;

  @override
  State<PositionValideButton> createState() => _PositionValideButtonState();
}

class _PositionValideButtonState extends State<PositionValideButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: transparent,
      onTap: widget.onPressed,
      child: Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            color: widget.color,
            borderRadius: BorderRadius.circular(8),
            boxShadow: const [
              BoxShadow(
                  color: shadow1,
                  offset: Offset(0, 1),
                  blurRadius: 8,
                  spreadRadius: 0),
              BoxShadow(
                  color: shadow2,
                  offset: Offset(0, 3),
                  blurRadius: 3,
                  spreadRadius: -2),
              BoxShadow(
                  color: shadow3,
                  offset: Offset(0, 3),
                  blurRadius: 4,
                  spreadRadius: 0)
            ],
          ),
          child: Container(
            alignment: Alignment.center,
            child: Text(widget.buttonText,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: widget.textColor,
                      fontFamily: 'OpenSans-Bold',
                      fontWeight: FontWeight.w700,
                      fontStyle: FontStyle.normal,
                    )),
          )),
    );
  }
}
