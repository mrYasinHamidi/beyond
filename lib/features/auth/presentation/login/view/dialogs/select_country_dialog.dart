import 'package:beyond/features/auth/domain/entities/country/country.dart';
import 'package:beyond/features/auth/presentation/login/cubit/login_cubit.dart';
import 'package:beyond/features/auth/presentation/login/view/widgets/country_list_item.dart';
import 'package:beyond/features/auth/presentation/login/view/widgets/search_dialog_appbar.dart';
import 'package:collection/collection.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SelectCountryDialog extends StatefulWidget {
  const SelectCountryDialog({super.key});

  @override
  State<SelectCountryDialog> createState() => _SelectCountryDialogState();
}

class _SelectCountryDialogState extends State<SelectCountryDialog> {
  bool search = false;
  late final cubit = context.read<LoginCubit>();

  /// null for Divider()
  /// not null for Country object
  late final countries = <Country?>[];

  @override
  void initState() {
    super.initState();
    _setCountries();
  }

  _setCountries({String searchTerm = ''}) {
    countries.clear();
    if (searchTerm.trim().isEmpty) {
      cubit.countries?.forEachIndexed((index, element) {
        countries.add(element);
        if ((cubit.countries!.length - 1) > index &&
            !element.name.startsWith(cubit.countries!.elementAt(index + 1).name.split('').first)) {
          countries.add(null);
        }
      });
    } else {
      countries.addAll(
        cubit.countries?.where((element) => element.name.toLowerCase().startsWith(searchTerm.toLowerCase())).toList() ??
            [],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actionsPadding: EdgeInsets.zero,
        leadingWidth: 0,
        automaticallyImplyLeading: false,
        title: SearchDialogAppbar(
          isSearchModel: search,
          onModelChange: (bool mode) => setState(() {
            search = mode;
          }),
          onSearching: (searchTerm) => setState(() {
            _setCountries(searchTerm: searchTerm);
          }),
        ),
      ),
      body: ListView.builder(
        itemCount: countries.length,
        itemBuilder: (_, index) => CountryListItem(
          country: countries[index],
          onTap: () {
            cubit.setCountry(countries[index]);
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}
