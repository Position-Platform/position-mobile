// ignore_for_file: file_names

import 'package:flutter/material.dart';

import 'package:position/src/core/utils/colors.dart';
import 'package:position/src/core/utils/sizes.dart';

class PositionTextFormField extends StatefulWidget {
  const PositionTextFormField(
      {super.key,
      required this.boxDecorationColor,
      required this.textController,
      required this.hintText,
      required this.labelText,
      required this.suffixIcon,
      required this.obscureText,
      required this.suffixIconOnPressed,
      required this.keyboardType});
  final Color boxDecorationColor;
  final TextEditingController textController;
  final String hintText;
  final String labelText;
  final IconData suffixIcon;
  final bool obscureText;
  final VoidCallback? suffixIconOnPressed;
  final TextInputType keyboardType;

  @override
  State<PositionTextFormField> createState() => _PositionTextFormFieldState();
}

class _PositionTextFormFieldState extends State<PositionTextFormField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      margin: const EdgeInsets.only(
        left: 50,
        right: 50,
      ),
      child: TextFormField(
        controller: widget.textController,
        obscureText: widget.obscureText,
        autovalidateMode: AutovalidateMode.always,
        keyboardType: TextInputType.text,
        style: Theme.of(context).textTheme.bodyMedium,
        autocorrect: false,
        cursorColor: primaryColor,
        cursorHeight: cursorHeight,
        decoration: InputDecoration(
          labelText: widget.labelText,
          labelStyle: Theme.of(context)
              .textTheme
              .bodyMedium
              ?.copyWith(color: greyColor),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: widget.boxDecorationColor),
          ),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: widget.boxDecorationColor)),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: widget.boxDecorationColor),
          ),
          suffixIcon: IconButton(
              icon: Icon(widget.suffixIcon, size: 20),
              color: greyColor,
              onPressed: widget.suffixIconOnPressed),
        ),
      ),
    );
  }
}
