import 'package:flutter/material.dart';

class ThemeChanger with ChangeNotifier {
  ThemeData _themeData;
  bool _isDarkMode = false;

  ThemeChanger(this._themeData);

  ThemeData get themeData => _themeData;

  bool get isDarkMode => _isDarkMode;

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    _themeData = _isDarkMode ? darkTheme : lightTheme;
    notifyListeners();
  }

  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      scrolledUnderElevation: 0.0,
    ),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: const Color(0xFF2C2C2E),

    // BG 303041
    // Blanco F4FCFE
    // BUTTON 3D3A50
    // BLUE 0EA2F6
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF2C2C2E),
      scrolledUnderElevation: 0.0,
      titleTextStyle: TextStyle(color: Color(0xffF4FCFE)),
    ),
  );
}
