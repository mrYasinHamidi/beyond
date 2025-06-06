import 'package:beyond/core/widgets/responsive_page.dart';
import 'package:beyond/features/auth/presentation/login/view/widgets/number_keyboard.dart';
import 'package:beyond/themes/app_theme.dart';
import 'package:beyond/themes/theme_cubit.dart';
import 'package:beyond/themes/theme_extension.dart';
import 'package:beyond/translation/translator_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:responsive_framework/responsive_framework.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsivePage(mobileView: _LoginPageMobile());
  }
}

class _LoginPageMobile extends StatelessWidget {
  const _LoginPageMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SafeArea(
            child: Row(
              children: [
                BlocBuilder<ThemeCubit, AppTheme>(
                  builder: (_, state) {
                    return IconButton(
                      onPressed: () => context.read<ThemeCubit>().changeTheme(),
                      icon: Icon(state == AppTheme.dark ? Icons.light_mode : Icons.dark_mode),
                    );
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: TextFormField(
              decoration: InputDecoration(label: Text(context.translator.phoneNumber)),
              keyboardType: TextInputType.number,
            ),
          ),
          Expanded(
            child: Stack(
              fit: StackFit.expand,
              children: [
                SvgPicture.asset(
                  'assets/images/login_back.svg',
                  fit: BoxFit.fill,
                  colorFilter: ColorFilter.mode(context.theme.colorScheme.primaryContainer, BlendMode.srcIn),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 70, 8, 0),
                  child: SafeArea(child: NumberKeyboard(onTapNumber: (number) {})),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
