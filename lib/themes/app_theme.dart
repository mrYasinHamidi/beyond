import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';

part 'app_dark_theme.dart';

part 'app_light_theme.dart';

enum AppTheme {
  dark,
  light;

  ThemeData themeData() {
    return switch (this) {
      AppTheme.light => AppLightTheme().themeData,
      AppTheme.dark => AppDarkTheme().themeData,
    };
  }
}
