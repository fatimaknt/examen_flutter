import 'package:flutter/material.dart';

class Constants {
  static const Color primaryColor = Color(0xff90B2F9);
  static const Color secondaryColor = Color(0xff90B2F8);

  static Color textColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? Colors.white
        : Colors.black;
  }

  static bool isDark(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }
}
