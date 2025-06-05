import 'dart:math';

import 'package:beyond/core/widgets/animated_icon/animate_icon.dart';
import 'package:beyond/core/widgets/animated_icon/animate_icon_config.dart';
import 'package:beyond/themes/app_theme.dart';
import 'package:beyond/themes/theme_cubit.dart';
import 'package:beyond/themes/theme_extension.dart';
import 'package:beyond/translation/translator_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          BlocBuilder<ThemeCubit, AppTheme>(
            builder: (_, state) {
              bool isDark = state == AppTheme.dark;
              return IconButton(
                onPressed: () => context.read<ThemeCubit>().changeTheme(),
                icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode),
              );
            },
          ),
        ],
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: SvgPicture.asset(
              'assets/images/login_back.svg',
              fit: BoxFit.fill,
              colorFilter: ColorFilter.mode(context.theme.colorScheme.secondary, BlendMode.srcIn),
            ),
          ),
          TextFormField(
            decoration: InputDecoration(label: Text(context.translator.phoneNumber)),
            keyboardType: TextInputType.number,
          ),
        ],
      ),
    );
  }
}
