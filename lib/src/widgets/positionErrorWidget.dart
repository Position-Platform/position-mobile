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
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(
            height: 40,
          ),
          TextButton(
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.resolveWith<Color>(
                  (Set<WidgetState> states) => primaryColor,
                ),
                overlayColor: WidgetStateProperty.all(Colors.transparent),
                shape: WidgetStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                )),
              ),
              onPressed: widget.onPressed,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Text(
                  PositionLocalizations.of(context).tryAgain,
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(color: whiteColor),
                  textAlign: TextAlign.center,
                ),
              ))
        ],
      ),
    );
  }
}
