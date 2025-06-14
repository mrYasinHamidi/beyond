part of 'app_theme.dart';

class AppLightTheme {
  ThemeData get _themeData => FlexThemeData.light(scheme: FlexScheme.deepBlue);

  ThemeData get themeData => _themeData.copyWith(
    visualDensity: VisualDensity.compact,
    colorScheme: colorSchema,
    scaffoldBackgroundColor: colorSchema.surface,
  );

  ColorScheme get colorSchema => _themeData.colorScheme;
}
