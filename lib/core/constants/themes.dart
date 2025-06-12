import 'package:flutter/material.dart';
import 'colors.dart';

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    primary: ColorsData.primaryLight,
    secondary: ColorsData.backgroundLight,
    onPrimary: ColorsData.textLight,
  ),
  scaffoldBackgroundColor: ColorsData.backgroundLight,
  appBarTheme: const AppBarTheme(
    backgroundColor: Color.fromARGB(255, 255, 255, 255),
    foregroundColor: ColorsData.primaryLight,
  ),
);

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    primary: ColorsData.primaryDark,
    secondary: ColorsData.backgroundDark,
    onPrimary: ColorsData.textDark,
  ),
  scaffoldBackgroundColor: ColorsData.backgroundDark,
  appBarTheme: const AppBarTheme(
    backgroundColor: Color.fromARGB(255, 255, 255, 255),
    foregroundColor: ColorsData.primaryDark,
  ),
);
