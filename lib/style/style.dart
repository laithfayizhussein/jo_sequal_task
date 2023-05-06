import 'package:flutter/material.dart';

class Style {
  static const Color accent = Color(0xff003C73);
  static const Color secondary = Color(0xff2D4A8A);
  static const Color tertiary = Color(0xff19ACFF);
  static const Color tertiary2 = Color(0xffB1A05A);
  static const Color black = Color(0xff1E1E1E);
  static const Color white = Color(0xffFFFFFF);
  static const Color darkText = Color(0xff575757);
  static const Color lightText = Color(0xff999999);
  static const Color hint = Color(0xffB7B7B7);
  static const Color background = Color(0xffF6F6F6);
  static const Color line = Color(0xffECECEC);
  static const Color confirmation = Color(0xff3EC585);
  static const Color error = Color(0xffe27070);

  static ThemeData mainTheme = ThemeData(
    appBarTheme: const AppBarTheme(
      elevation: 0.0,
      centerTitle: false,
      actionsIconTheme: IconThemeData(color: black),
      color: background,
      iconTheme: IconThemeData(color: black),
    ),
    brightness: Brightness.light,
    primaryColor: accent,
    colorScheme: ThemeData().colorScheme.copyWith(
          primary: accent,
          onPrimary: tertiary,
          secondary: secondary,
          onSecondary: tertiary2,
          errorContainer: error,
          onError: error,
          onErrorContainer: error,
          background: background,
          brightness: Brightness.light,
          error: error,
        ),
    backgroundColor: background,
    scaffoldBackgroundColor: background,
    dividerColor: line,
  );
}
