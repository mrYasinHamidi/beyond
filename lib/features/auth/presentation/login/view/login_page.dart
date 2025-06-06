import 'package:beyond/core/widgets/responsive_page.dart';
import 'package:beyond/features/auth/presentation/login/cubit/login_cubit.dart';
import 'package:beyond/features/auth/presentation/login/view/widgets/number_keyboard.dart';
import 'package:beyond/injection/app_injection.dart';
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
    return BlocProvider<LoginCubit>(
      create: (BuildContext context) => getIt(),
      child: ResponsivePage(mobileView: _LoginPageMobile()),
    );
  }
}

class _LoginPageMobile extends StatefulWidget {
  const _LoginPageMobile({super.key});

  @override
  State<_LoginPageMobile> createState() => _LoginPageMobileState();
}

class _LoginPageMobileState extends State<_LoginPageMobile> {
  late final cubit = context.read<LoginCubit>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        actions: [
          IconButton(
            onPressed: () => context.read<ThemeCubit>().changeTheme(),
            icon: BlocBuilder<ThemeCubit, AppTheme>(
              builder: (_, state) {
                return Icon(state == AppTheme.dark ? Icons.light_mode : Icons.dark_mode);
              },
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: cubit.phoneController,
                  decoration: InputDecoration(
                    label: Text(context.translator.phoneNumber),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                    prefixText: '+98 | ',
                    isDense: false,
                  ),
                  keyboardType: TextInputType.number,
                ),
              ],
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
                  padding: const EdgeInsets.fromLTRB(8, 110, 8, 0),
                  child: SafeArea(
                    child: NumberKeyboard(
                      onTapNumber: (number) {
                        cubit.phoneNumberInserted(number);
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
