import 'package:beyond/app_router.dart';
import 'package:beyond/injection/app_injection.dart';
import 'package:beyond/themes/app_theme.dart';
import 'package:beyond/themes/theme_cubit.dart';
import 'package:beyond/translation/app_translation.dart';
import 'package:beyond/translation/language_cubit.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

void main() => initializeApplication().then((value) => runApp(MyApp()));

Future<void> initializeApplication() async {
  WidgetsFlutterBinding.ensureInitialized();

  configureDependencies();

  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorageDirectory.web
        : HydratedStorageDirectory((await getTemporaryDirectory()).path),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: getIt<ThemeCubit>()),
        BlocProvider.value(value: getIt<LanguageCubit>()),
      ],
      child: BlocBuilder<LanguageCubit, Locale>(
        builder: (_, locale) {
          return BlocBuilder<ThemeCubit, AppTheme>(
            builder: (_, appTheme) {
              return MaterialApp.router(
                routerConfig: router,
                theme: appTheme.themeData(),
                locale: locale,
                localizationsDelegates: AppLocalizations.localizationsDelegates,
                supportedLocales: AppLocalizations.supportedLocales,
              );
            },
          );
        },
      ),
    );
  }
}
