import 'package:beyond/features/auth/presentation/login/view/login_page.dart';
import 'package:beyond/routes/app_router.dart';
import 'package:beyond/themes/theme_cubit.dart';
import 'package:beyond/translation/language_cubit.dart';
import 'package:beyond/translation/translator_extension.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.userChanges().listen((event) {
      print(event);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('sd')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(context.translator.helloWorld),
          ElevatedButton(onPressed: () => context.read<ThemeCubit>().changeTheme(), child: Text('theme')),
          ElevatedButton(onPressed: () => context.read<LanguageCubit>().changeLanguage(), child: Text('language')),
          ElevatedButton(
            onPressed: () {
              LoginRoute().go(context);
            },
            child: Text('otp'),
          ),
        ],
      ),
    );
  }
}
