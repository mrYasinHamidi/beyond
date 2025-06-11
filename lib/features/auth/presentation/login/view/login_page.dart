import 'package:beyond/core/widgets/responsive_page.dart';
import 'package:beyond/features/auth/presentation/login/cubit/login_cubit.dart';
import 'package:beyond/features/auth/presentation/login/view/widgets/country_selector_button.dart';
import 'package:beyond/features/auth/presentation/login/view/widgets/number_keyboard.dart';
import 'package:beyond/features/auth/presentation/login/view/widgets/phone_field.dart';
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
    final keyboardHeight = size.width / 1.618 + 100;
    return Scaffold(
      appBar: AppBar(
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
              padding: const EdgeInsets.all(32),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Spacer(),
                  Text(
                    'Phone Number',
                    style: context.theme.textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  Gap(8),
                  Text('Please confirm your country code\nand enter your phone number.'),
                  const Spacer(),
                  CountrySelectorButton(),
                  Gap(8),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: cubit.countryCodeController,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(isDense: false),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      const Gap(8),
                      Expanded(flex: 6, child: PhoneField(controller: cubit.phoneController)),
                    ],
                  ),
                  const Spacer(),
                ],
              ),
            ),
          ),
          SizedBox(
            height: keyboardHeight,
            child: Stack(
              fit: StackFit.expand,
              children: [
                SvgPicture.asset(
                  'assets/images/login_back.svg',
                  fit: BoxFit.fill,
                  colorFilter: ColorFilter.mode(context.theme.colorScheme.primaryContainer, BlendMode.srcIn),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 100, 8, 8),
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
