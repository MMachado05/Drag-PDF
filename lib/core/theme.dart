import 'package:flutter/material.dart';

class AppTheme {
  static const Color errorColor = Color(0xFFB00020);

  static final ThemeData lightTheme = ThemeData(
    primaryColor: Colors.white,
    colorScheme: const ColorScheme.light(
      primary: Color(0xFF1D2353),
      error: errorColor,
    ),
    scaffoldBackgroundColor: Color(0xFFAAD1F0),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF1D2353),
      foregroundColor: Colors.white,
      elevation: 4.0,
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
      ),
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(fontSize: 18.0, color: Colors.black87),
      bodyMedium: TextStyle(fontSize: 16.0, color: Colors.black54),
      headlineLarge: TextStyle(
        fontSize: 32.0,
        fontWeight: FontWeight.bold,
        color: Color(0xFF1D2353),
      ),
      headlineMedium: TextStyle(
        fontSize: 24.0,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
    ),
    buttonTheme: const ButtonThemeData(
      buttonColor: Color(0xFF1D2353),
      textTheme: ButtonTextTheme.primary,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xFF1D2353),
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
        textStyle: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
      ),
    ),
    cardTheme: const CardTheme(elevation: 2.0, margin: EdgeInsets.all(8.0)),
  );

  static final ThemeData darkTheme = ThemeData(
    primaryColor: Colors.white,
    colorScheme: const ColorScheme.dark(
      primary: Colors.white,
      surface: Color(0xFF1E1E1E),
      error: errorColor,
    ),
    scaffoldBackgroundColor: const Color(0xFF303030),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF121212),
      foregroundColor: Colors.white,
      elevation: 4.0,
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
      ),
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(fontSize: 18.0, color: Colors.white),
      bodyMedium: TextStyle(fontSize: 16.0, color: Colors.white70),
      headlineLarge: TextStyle(
        fontSize: 32.0,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      headlineMedium: TextStyle(
        fontSize: 24.0,
        fontWeight: FontWeight.bold,
        color: Colors.white70,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.black87,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
      ),
    ),
    cardTheme: const CardTheme(
      color: Color(0xFF1E1E1E),
      elevation: 2.0,
      margin: EdgeInsets.all(8.0),
    ),
  );
}
