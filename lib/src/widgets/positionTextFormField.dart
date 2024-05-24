// ignore_for_file: file_names

import 'package:flutter/material.dart';

import 'package:position/src/core/utils/colors.dart';

class PositionTextFormField extends StatefulWidget {
  const PositionTextFormField(
      {super.key,
      required this.boxDecorationColor,
      required this.textController,
      required this.textSize,
      required this.hintText,
      required this.labelText,
      required this.suffixIcon,
      required this.obscureText,
      required this.suffixIconOnPressed,
      required this.keyboardType});
  final Color boxDecorationColor;
  final TextEditingController textController;
  final double textSize;
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
        style: TextStyle(fontFamily: "OpenSans", fontSize: widget.textSize),
        autocorrect: false,
        cursorColor: primaryColor,
        cursorHeight: 20,
        decoration: InputDecoration(
          labelText: widget.labelText,
          labelStyle: TextStyle(
            fontFamily: "OpenSans",
            fontSize: widget.textSize,
            color: greyColor,
          ),
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
