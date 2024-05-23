// ignore_for_file: file_names

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:position/src/core/utils/colors.dart';
import 'package:position/src/modules/app/bloc/app_bloc.dart';

class PositionChooseLanguage extends StatefulWidget {
  const PositionChooseLanguage(
      {super.key,
      required this.appLocale,
      required this.textSize,
      required this.appBloc});
  final Locale appLocale;
  final double textSize;
  final AppBloc appBloc;

  @override
  State<PositionChooseLanguage> createState() => _PositionChooseLanguageState();
}

class _PositionChooseLanguageState extends State<PositionChooseLanguage> {
  @override
  Widget build(BuildContext context) {
    List<String> languagesItems = [
      'Français',
      'English',
    ];
    return SizedBox(
      width: 150,
      child: DropdownButtonFormField2(
        decoration: InputDecoration(
          isDense: true,
          contentPadding: EdgeInsets.zero,
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(color: whiteColor)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(color: whiteColor)),
        ),
        isExpanded: false,
        hint: Text(
          widget.appLocale.languageCode == "fr"
              ? languagesItems[0]
              : languagesItems[1],
          style: TextStyle(
              fontSize: widget.textSize,
              color: whiteColor,
              fontFamily: "OpenSans"),
        ),
        iconStyleData: const IconStyleData(
          icon: Icon(
            Icons.arrow_drop_down,
            color: whiteColor,
          ),
          iconSize: 30,
        ),
        buttonStyleData: const ButtonStyleData(
          height: 40,
          padding: EdgeInsets.only(left: 20, right: 10),
        ),
        dropdownStyleData: DropdownStyleData(
          decoration: BoxDecoration(
            color: accentColor,
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        items: languagesItems
            .map((item) => DropdownMenuItem<String>(
                  value: item,
                  child: Text(
                    item,
                    style: TextStyle(
                        fontSize: widget.textSize,
                        color: whiteColor,
                        fontFamily: "OpenSans"),
                  ),
                ))
            .toList(),
        validator: (value) {
          if (value == null) {
            return widget.appLocale.languageCode == "fr"
                ? languagesItems[0]
                : languagesItems[1];
          }
          return null;
        },
        onChanged: (value) {
          if (value == "Français") {
            widget.appBloc.add(const ChangeLanguage(Locale("fr", "FR")));
          } else {
            widget.appBloc.add(const ChangeLanguage(Locale("en", "US")));
          }
        },
        onSaved: (value) {
          // selectedValue = value.toString();
        },
      ),
    );
  }
}
