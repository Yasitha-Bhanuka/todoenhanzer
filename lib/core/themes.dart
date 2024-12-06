import 'package:flutter/material.dart';
import 'package:sqlflitetodo/core/app_pallete.dart';

final ThemeData darkTheme = ThemeData.dark().copyWith(
  scaffoldBackgroundColor: Pallete.backgroundColor,
  primaryColor: Pallete.gradient1,
  cardColor: Pallete.cardColor,

  // AppBar Theme
  appBarTheme: const AppBarTheme(
    backgroundColor: Pallete.backgroundColor,
    elevation: 0,
    iconTheme: IconThemeData(color: Pallete.gradient1),
    actionsIconTheme: IconThemeData(color: Pallete.gradient1),
    titleTextStyle: TextStyle(
      color: Pallete.whiteColor,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
  ),

  // Text Themes
  textTheme: const TextTheme(
    headlineLarge: TextStyle(
        color: Pallete.whiteColor, fontSize: 26, fontWeight: FontWeight.bold),
    headlineMedium: TextStyle(
        color: Pallete.whiteColor, fontSize: 22, fontWeight: FontWeight.w600),
    bodyLarge: TextStyle(color: Pallete.whiteColor, fontSize: 16),
    bodyMedium: TextStyle(color: Pallete.whiteColor, fontSize: 14),
    labelLarge: TextStyle(
        color: Pallete.gradient1, fontSize: 16, fontWeight: FontWeight.w500),
  ),

  // Icon Theme
  iconTheme: const IconThemeData(color: Pallete.gradient1),
  primaryIconTheme: const IconThemeData(color: Pallete.gradient1),

  // Input Decoration
  inputDecorationTheme: InputDecorationTheme(
    fillColor: Pallete.cardColor,
    filled: true,
    contentPadding: const EdgeInsets.all(16),
    hintStyle: const TextStyle(color: Pallete.subtitleText),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: Pallete.borderColor),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: Pallete.gradient1, width: 2),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: Pallete.errorColor),
    ),
  ),

  // Bottom Navigation Bar
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Pallete.cardColor,
    selectedItemColor: Pallete.gradient1,
    unselectedItemColor: Pallete.inactiveBottomBarItemColor,
  ),

  // Card Theme
  cardTheme: CardTheme(
    color: Pallete.cardColor,
    elevation: 2,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
  ),

  // Floating Action Button
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Pallete.gradient1,
    foregroundColor: Pallete.whiteColor,
  ),
);

final ThemeData lightTheme = ThemeData.light().copyWith(
  scaffoldBackgroundColor: Pallete.whiteColor,
  primaryColor: Pallete.gradient2,
  cardColor: Pallete.whiteColor,

  // AppBar Theme
  appBarTheme: const AppBarTheme(
    backgroundColor: Pallete.whiteColor,
    elevation: 0,
    iconTheme: IconThemeData(color: Pallete.gradient2),
    actionsIconTheme: IconThemeData(color: Pallete.gradient2),
    titleTextStyle: TextStyle(
      color: Pallete.backgroundColor,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
  ),

  // Text Themes
  textTheme: const TextTheme(
    headlineLarge: TextStyle(
        color: Pallete.backgroundColor,
        fontSize: 26,
        fontWeight: FontWeight.bold),
    headlineMedium: TextStyle(
        color: Pallete.backgroundColor,
        fontSize: 22,
        fontWeight: FontWeight.w600),
    bodyLarge: TextStyle(color: Pallete.backgroundColor, fontSize: 16),
    bodyMedium: TextStyle(color: Pallete.backgroundColor, fontSize: 14),
    labelLarge: TextStyle(
        color: Pallete.gradient2, fontSize: 16, fontWeight: FontWeight.w500),
  ),

  // Icon Theme
  iconTheme: const IconThemeData(color: Pallete.gradient2),
  primaryIconTheme: const IconThemeData(color: Pallete.gradient2),

  // Input Decoration
  inputDecorationTheme: InputDecorationTheme(
    fillColor: Pallete.whiteColor,
    filled: true,
    contentPadding: const EdgeInsets.all(16),
    hintStyle: const TextStyle(color: Pallete.greyColor),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: Pallete.borderColor),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: Pallete.gradient2, width: 2),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: Pallete.errorColor),
    ),
  ),

  // Bottom Navigation Bar
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Pallete.whiteColor,
    selectedItemColor: Pallete.gradient2,
    unselectedItemColor: Pallete.inactiveBottomBarItemColor,
  ),

  // Card Theme
  cardTheme: CardTheme(
    color: Pallete.whiteColor,
    elevation: 1,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
  ),

  // Floating Action Button
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Pallete.gradient2,
    foregroundColor: Pallete.whiteColor,
  ),
);

OutlineInputBorder border(Color color) => OutlineInputBorder(
      borderSide: BorderSide(
        color: color,
        width: 2,
      ),
      borderRadius: BorderRadius.circular(10),
    );
