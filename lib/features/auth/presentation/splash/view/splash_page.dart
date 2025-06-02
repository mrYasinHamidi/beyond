import 'package:beyond/themes/theme_cubit.dart';
import 'package:beyond/translation/language_cubit.dart';
import 'package:beyond/translation/translator_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('sd'),),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(context.translator.helloWorld),
          ElevatedButton(onPressed: () => context.read<ThemeCubit>().changeTheme(), child: Text('theme')),
          ElevatedButton(onPressed: () => context.read<LanguageCubit>().changeLanguage(), child: Text('language')),
        ],
      ),
    );
  }
}
