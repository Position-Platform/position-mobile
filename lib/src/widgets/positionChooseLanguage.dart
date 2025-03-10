// ignore_for_file: file_names

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:position/src/core/utils/colors.dart';

class PositionChooseLanguage extends StatefulWidget {
  const PositionChooseLanguage({super.key, required this.selectLanguage});

  final Function(String language) selectLanguage;

  @override
  State<PositionChooseLanguage> createState() => _PositionChooseLanguageState();
}

class _PositionChooseLanguageState extends State<PositionChooseLanguage> {
  @override
  Widget build(BuildContext context) {
    final Locale appLocale = Localizations.localeOf(context);
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
            appLocale.languageCode == "fr"
                ? languagesItems[0]
                : languagesItems[1],
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: whiteColor)),
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
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color: whiteColor),
                  ),
                ))
            .toList(),
        validator: (value) {
          if (value == null) {
            return appLocale.languageCode == "fr"
                ? languagesItems[0]
                : languagesItems[1];
          }
          return null;
        },
        onChanged: (value) {
          widget.selectLanguage(value!);
        },
        onSaved: (value) {
          // selectedValue = value.toString();
        },
      ),
    );
  }
}
