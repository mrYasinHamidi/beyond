part of 'app_theme.dart';

class AppDarkTheme {
  ThemeData get _themeData => FlexThemeData.dark(scheme: FlexScheme.deepBlue);

  ThemeData get themeData => _themeData.copyWith(
    visualDensity: VisualDensity.compact,
    colorScheme: colorSchema,
    scaffoldBackgroundColor: colorSchema.surface,
  );

  ColorScheme get colorSchema => _themeData.colorScheme;
}
