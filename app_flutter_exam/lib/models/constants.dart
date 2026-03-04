import 'package:flutter/material.dart';

class Constants {
  static const Color primaryLight = Color(0xff6696f5);
  static const Color secondaryLight = Color(0xffE0E8FB);
  static const Color primaryDark = Color(0xff6696f5);
  static const Color secondaryDark = Color(0xff2a2a4a);

  static Color primaryColor(BuildContext context) =>
      Theme.of(context).primaryColor;

  static Color secondaryColor(BuildContext context) =>
      Theme.of(context).colorScheme.secondary;

  static Color cardColor(BuildContext context) =>
      Theme.of(context).cardColor;

  static Color textColor(BuildContext context) =>
      Theme.of(context).colorScheme.onSurface;

  static bool isDark(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark;
}