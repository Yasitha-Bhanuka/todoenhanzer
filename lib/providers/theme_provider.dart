import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Pallete {
  static const cardColor = Color.fromRGBO(30, 30, 30, 1);
  static const greenColor = Colors.green;
  static const subtitleText = Color(0xffa7a7a7);
  static const inactiveBottomBarItemColor = Color(0xffababab);
  static const Color backgroundColor = Color.fromRGBO(18, 18, 18, 1);
  static const Color gradient1 = Color.fromRGBO(187, 63, 221, 1);
  static const Color gradient2 = Color.fromRGBO(251, 109, 169, 1);
  static const Color gradient3 = Color.fromRGBO(255, 159, 124, 1);
  static const Color borderColor = Color.fromRGBO(52, 51, 67, 1);
  static const Color whiteColor = Color(0xFFF5F5F5); // A softer white color
  static const Color greyColor = Colors.grey;
  static const Color errorColor = Color.fromARGB(255, 255, 0, 0);
  static const Color transparentColor = Colors.transparent;
  static const Color inactiveSeekColor = Colors.white38;
}

class ThemeProvider extends ChangeNotifier {
  static const String _themePreferenceKey = 'isDarkMode';
  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  ThemeData get currentTheme => _isDarkMode ? _darkTheme : _lightTheme;

  ThemeProvider() {
    _loadThemePreference();
  }

  void toggleTheme() async {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
    await _saveThemePreference();
  }

  Future<void> _saveThemePreference() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(_themePreferenceKey, _isDarkMode);
  }

  Future<void> _loadThemePreference() async {
    final prefs = await SharedPreferences.getInstance();
    _isDarkMode = prefs.getBool(_themePreferenceKey) ?? false;
    notifyListeners();
  }

  static OutlineInputBorder _border(Color color) => OutlineInputBorder(
        borderSide: BorderSide(
          color: color,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(10),
      );

  static final ThemeData _lightTheme = ThemeData.light().copyWith(
    scaffoldBackgroundColor: Pallete.whiteColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: Pallete.whiteColor,
      elevation: 0,
      iconTheme: IconThemeData(color: Pallete.gradient2),
      titleTextStyle: TextStyle(
        color: Pallete.backgroundColor,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
    iconTheme: const IconThemeData(color: Pallete.gradient2),
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(18),
      enabledBorder: _border(Pallete.borderColor),
      focusedBorder: _border(Pallete.gradient2),
      errorBorder: _border(Pallete.errorColor),
      focusedErrorBorder: _border(Pallete.errorColor),
    ),
    checkboxTheme: CheckboxThemeData(
      checkColor: WidgetStateProperty.all(Pallete.whiteColor),
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return Pallete.gradient2;
        }
        return const Color.fromARGB(49, 52, 51, 67);
      }),
    ),
  );

  static final ThemeData _darkTheme = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: Pallete.backgroundColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: Pallete.backgroundColor,
      elevation: 0,
      iconTheme: IconThemeData(color: Pallete.gradient1),
      titleTextStyle: TextStyle(
        color: Pallete.whiteColor,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
    iconTheme: const IconThemeData(color: Pallete.gradient1),
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(18),
      enabledBorder: _border(Pallete.borderColor),
      focusedBorder: _border(Pallete.gradient1),
      errorBorder: _border(Pallete.errorColor),
      focusedErrorBorder: _border(Pallete.errorColor),
    ),
    checkboxTheme: CheckboxThemeData(
      checkColor: WidgetStateProperty.all(Pallete.whiteColor),
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return Pallete.gradient1;
        }
        return Pallete.borderColor;
      }),
    ),
    // textTheme: const TextTheme(
    //   bodyMedium: TextStyle(color: Colors.white),
    // ),
  );
}
