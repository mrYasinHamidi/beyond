import 'package:beyond/core/widgets/responsive_page.dart';
import 'package:beyond/features/auth/presentation/login/cubit/login_cubit.dart';
import 'package:beyond/features/auth/presentation/login/view/widgets/country_selector_button.dart';
import 'package:beyond/features/auth/presentation/login/view/widgets/number_keyboard.dart';
import 'package:beyond/injection/app_injection.dart';
import 'package:beyond/themes/app_theme.dart';
import 'package:beyond/themes/theme_cubit.dart';
import 'package:beyond/themes/theme_extension.dart';
import 'package:beyond/translation/translator_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

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
    final size = MediaQuery.of(context).size;
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
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CountrySelectorButton(),
                  Gap(8),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: cubit.countryCodeController,textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            isDense: false,
                          ),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      const Gap(8),
                      Expanded(
                        flex: 7,
                        child: TextFormField(
                          controller: cubit.phoneController,
                          decoration: InputDecoration(
                            label: Text(context.translator.phoneNumber),
                            isDense: false,
                          ),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          ConstrainedBox(
            constraints: BoxConstraints(maxHeight: size.height * .35),
            child: Stack(
              fit: StackFit.expand,
              children: [
                SvgPicture.asset(
                  'assets/images/login_back.svg',
                  fit: BoxFit.fill,
                  colorFilter: ColorFilter.mode(context.theme.colorScheme.primaryContainer, BlendMode.srcIn),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 80, 8, 8),
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
