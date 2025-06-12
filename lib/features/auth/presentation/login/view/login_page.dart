import 'package:beyond/core/utils/fixed_prefix_formatter.dart';
import 'package:beyond/core/widgets/responsive_page.dart';
import 'package:beyond/features/auth/presentation/login/cubit/login_cubit.dart';
import 'package:beyond/features/auth/presentation/login/view/widgets/country_selector_button.dart';
import 'package:beyond/features/auth/presentation/login/view/widgets/number_keyboard.dart';
import 'package:beyond/core/widgets/phone_field.dart';
import 'package:beyond/injection/app_injection.dart';
import 'package:beyond/themes/app_theme.dart';
import 'package:beyond/themes/theme_cubit.dart';
import 'package:beyond/themes/theme_extension.dart';
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
                  BlocBuilder<LoginCubit, LoginState>(
                    buildWhen: (_, state) => state is CountryState,
                    builder: (_, state) {
                      return CountrySelectorButton(selected: cubit.selectedCountry);
                    },
                  ),
                  Gap(8),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: cubit.countryCodeController,
                          textAlign: TextAlign.center,
                          inputFormatters: [FixedPrefixFormatter('+')],
                          decoration: InputDecoration(contentPadding: EdgeInsets.fromLTRB(0, 20, 0, 12), isDense: true),
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
          AspectRatio(
            aspectRatio: 1,
            child: Stack(
              fit: StackFit.expand,
              children: [
                SvgPicture.asset(
                  'assets/images/login_back.svg',
                  fit: BoxFit.fill,
                  colorFilter: ColorFilter.mode(context.theme.colorScheme.primaryContainer, BlendMode.srcIn),
                ),
                SafeArea(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: FractionallySizedBox(
                      widthFactor: 1,
                      heightFactor: .65,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: NumberKeyboard(
                          onTapNumber: (number) {
                            cubit.phoneNumberInserted(number);
                          },
                        ),
                      ),
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
