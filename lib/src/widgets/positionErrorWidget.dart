// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:position/generated/l10n.dart';
import 'package:position/src/core/utils/colors.dart';

class PositionErrorWidget extends StatefulWidget {
  const PositionErrorWidget(
      {super.key, required this.message, required this.onPressed});
  final String message;
  final VoidCallback onPressed;

  @override
  State<PositionErrorWidget> createState() => _PositionErrorWidgetState();
}

class _PositionErrorWidgetState extends State<PositionErrorWidget> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            "assets/images/png/ghostf.png",
            height: 150,
            width: 150,
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            widget.message,
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                fontFamily: "OpenSans"),
          ),
          const SizedBox(
            height: 40,
          ),
          TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith<Color>(
                  (Set<MaterialState> states) => primaryColor,
                ),
                overlayColor: MaterialStateProperty.all(Colors.transparent),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                )),
              ),
              onPressed: widget.onPressed,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Text(
                  PositionLocalizations.of(context).tryAgain,
                  style: const TextStyle(fontSize: 16, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ))
        ],
      ),
    );
  }
}
