import 'package:flutter/material.dart';
import 'package:app_flutter_exam/models/constants.dart';
import 'package:app_flutter_exam/ui/get_started.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  static _MyAppState? of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>();

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.system;

  void toggleTheme() {
    setState(() {
      _themeMode =
          _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    });
  }

  bool get isDark => _themeMode == ThemeMode.dark;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      debugShowCheckedModeBanner: false,
      themeMode: _themeMode,
      theme: ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: Colors.white,
        primaryColor: Constants.primaryLight,
        // ✅ const supprimé
        colorScheme: ColorScheme.light(
          primary: Constants.primaryLight,
          secondary: Constants.secondaryLight,
          surface: Colors.white,
          onSurface: Colors.black87,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black87,
          elevation: 0,
        ),
        cardColor: Colors.white,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xff1a1a2e),
        primaryColor: Constants.primaryDark,
        colorScheme: ColorScheme.dark(
          primary: Constants.primaryDark,
          secondary: Constants.secondaryDark,
          surface: const Color(0xff16213e),
          onSurface: Colors.white70,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xff1a1a2e),
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        cardColor: const Color(0xff16213e),
      ),
      home: const GetStarted(),
    );
  }
}