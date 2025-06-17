import 'package:flutter/material.dart';

class ColorsData {
  // Primary brand color (derived from the “M” and background)
  static const Color primaryLight = Color.fromRGBO(255, 193, 7, 1); // Amber
  static const Color primaryDark = Color.fromRGBO(
    255,
    160,
    0,
    1,
  ); // Darker Amber

  // Backgrounds
  static const Color backgroundLight = Color.fromRGBO(
    255,
    248,
    225,
    1,
  ); // Light Warm Cream
  static const Color backgroundDark = Color.fromRGBO(
    38,
    32,
    22,
    1,
  ); // Deep Warm Brown

  // Text
  static const Color textLight = Color.fromRGBO(
    33,
    33,
    33,
    1,
  ); // Almost Black for Light Mode
  static const Color textDark = Color.fromRGBO(
    255,
    255,
    255,
    1,
  ); // White for Dark Mode

  // Accent / CTA (Call to Action) colors
  static const Color accent = Color.fromRGBO(
    255,
    87,
    34,
    1,
  ); // Deep Orange (for buttons)
  static const Color secondaryAccent = Color.fromRGBO(
    255,
    238,
    88,
    1,
  ); // Soft Yellow (hover/effects)

  // Gradient Colors (for backgrounds or buttons)
  static const Color gradientStart = Color.fromRGBO(
    255,
    211,
    33,
    1,
  ); // Warm Yellow
  static const Color gradientMiddle = Color.fromRGBO(255, 153, 0, 1); // Amber
  static const Color gradientEnd = Color.fromRGBO(
    204,
    102,
    0,
    1,
  ); // Deep Orange
}
