import 'package:animations/animations.dart';
import 'package:beyond/features/auth/presentation/login/cubit/login_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class SelectCountryDialog extends StatefulWidget {
  const SelectCountryDialog({super.key});

  @override
  State<SelectCountryDialog> createState() => _SelectCountryDialogState();
}

class _SelectCountryDialogState extends State<SelectCountryDialog> {
  bool search = false;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<LoginCubit>();
    return Scaffold(
      appBar: AppBar(
        actionsPadding: EdgeInsets.zero,
        leadingWidth: 0,
        automaticallyImplyLeading: false,
        title: PageTransitionSwitcher(
          reverse: !search,
          transitionBuilder: (Widget child, Animation<double> primaryAnimation, Animation<double> secondaryAnimation) {
            return SharedAxisTransition(
              animation: primaryAnimation,
              fillColor: Colors.transparent,
              secondaryAnimation: secondaryAnimation,
              transitionType: SharedAxisTransitionType.vertical,
              child: child,
            );
          },
          child: search
              ? Row(
                  key: ValueKey('searchBar'),
                  children: [
                    IconButton(
                      onPressed: () {
                        setState(() {
                          search = false;
                        });
                      },
                      icon: Icon(Icons.close),
                    ),
                    const Gap(16),
                    Expanded(
                      child: TextField(
                        autofocus: true,
                        decoration: InputDecoration(border: InputBorder.none, hintText: 'Search'),
                      ),
                    ),
                  ],
                )
              : Row(
                  key: ValueKey('title'),
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.arrow_back_ios),
                    ),
                    Text('Choose a country'),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          search = true;
                        });
                      },
                      icon: Icon(Icons.search),
                    ),
                  ],
                ),
        ),
      ),
      body: ScrollablePositionedList.builder(
        itemCount: cubit.countries?.length ?? 0,
        initialScrollIndex: cubit.selectedCountry == null ? 0 : cubit.countries?.indexOf(cubit.selectedCountry!) ?? 0,
        itemBuilder: (context, index) {
          final country = cubit.countries![index];
          return ListTile(
            onTap: () {
              cubit.setCountry(country);
              Navigator.pop(context);
            },
            title: Text('${country.flag} ${country.name}'),
            trailing: Text(country.dialCode),
          );
        },
      ),
    );
  }
}
