import 'package:flutter/material.dart';
import 'package:position/src/core/utils/colors.dart';
import 'package:position/src/core/utils/sizes.dart';

class AppThemes {
  // Définit les styles de texte partagés entre les thèmes clair et foncé
  static const _textTheme = TextTheme(
    bodyLarge: TextStyle(
      fontFamily: "OpenSans-Bold",
      fontSize: textSizeLarge,
    ),
    bodyMedium: TextStyle(
      fontFamily: "OpenSans",
      fontSize: textSizeMedium,
    ),
    bodySmall: TextStyle(
      fontFamily: "OpenSans",
      fontSize: textSizeSmall,
    ),
  );

  // Définit les objets ThemeData pour les thèmes clair et foncé
  static final appThemeData = {
    AppTheme.lightTheme: ThemeData(
      scaffoldBackgroundColor: whiteColor,
      primaryColor: primaryColor,
      canvasColor: whiteColor,
      primaryIconTheme: const IconThemeData(color: blackColor),
      // Utilise les styles de texte partagés et définit les couleurs de texte
      textTheme: _textTheme.copyWith(
        bodyLarge: _textTheme.bodyLarge?.copyWith(color: blackColor),
        bodyMedium: _textTheme.bodyMedium?.copyWith(color: blackColor),
        bodySmall: _textTheme.bodySmall?.copyWith(color: blackColor),
      ),
      textSelectionTheme:
          const TextSelectionThemeData(cursorColor: accentColor),
      // Définit le schéma de couleurs pour le thème clair
      colorScheme:
          const ColorScheme.light(primary: primaryColor, secondary: accentColor)
              .copyWith(background: whiteColor),
      fontFamily: "OpenSans",
    ),
    AppTheme.darkTheme: ThemeData(
        scaffoldBackgroundColor: blackColor,
        primaryColor: primaryDarkColor,
        canvasColor: blackColor,
        primaryIconTheme: const IconThemeData(color: whiteColor),
        // Utilise les styles de texte partagés et définit les couleurs de texte
        textTheme: _textTheme.copyWith(
          bodyLarge: _textTheme.bodyLarge?.copyWith(color: whiteColor),
          bodyMedium: _textTheme.bodyMedium?.copyWith(color: whiteColor),
          bodySmall: _textTheme.bodySmall?.copyWith(color: whiteColor),
        ),
        textSelectionTheme:
            const TextSelectionThemeData(cursorColor: accentColor),
        // Définit le schéma de couleurs pour le thème foncé
        colorScheme: const ColorScheme.light(
                primary: primaryDarkColor, secondary: accentColor)
            .copyWith(background: blackColor),
        fontFamily: "OpenSans")
  };
}

// Énumération pour représenter les deux thèmes disponibles
enum AppTheme {
  lightTheme,
  darkTheme,
}
