// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:position/src/core/utils/colors.dart';

class PositionCategorieChips extends StatefulWidget {
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
  State<PositionCategorieChips> createState() => _PositionCategorieChipsState();
}

class _PositionCategorieChipsState extends State<PositionCategorieChips> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.callback,
      highlightColor: transparent,
      child: Chip(
        labelPadding: const EdgeInsets.all(1.0),
        shape: StadiumBorder(
            side: BorderSide(
          color: Theme.of(context).colorScheme.background,
        )),
        avatar: CircleAvatar(
          backgroundColor: transparent,
          child: SvgPicture.asset(
            "assets${widget.icon}",
            height: 15,
            width: 15,
          ),
        ),
        label: Text(
          widget.label,
          style: const TextStyle(
              color: blackColor, fontFamily: "OpenSans-Bold", fontSize: 11),
        ),
        backgroundColor: Theme.of(context).colorScheme.background,
        elevation: 10.0,
        shadowColor: transparent,
        padding: const EdgeInsets.all(6.0),
      ),
    );
  }
}
