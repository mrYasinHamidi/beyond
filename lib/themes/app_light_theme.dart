part of 'app_theme.dart';

class AppLightTheme {
  ThemeData get _themeData => FlexThemeData.light(scheme: FlexScheme.deepBlue);

  late final themeData = _themeData.copyWith(appBarTheme: appBarTheme);

  late final appBarTheme = _themeData.appBarTheme.copyWith(elevation: 0, backgroundColor: Colors.transparent);
}
