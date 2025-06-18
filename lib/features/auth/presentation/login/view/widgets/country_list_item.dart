import 'package:beyond/features/auth/domain/entities/country/country.dart';
import 'package:flutter/material.dart';

class CountryListItem extends StatelessWidget {
  final Country? country;
  final VoidCallback? onTap;

  const CountryListItem({super.key, required this.country, this.onTap});

  @override
  Widget build(BuildContext context) {
    if (country == null) return const Divider(indent: 16, endIndent: 16);
    return ListTile(onTap: onTap, title: Text('${country!.flag} ${country!.name}'), trailing: Text(country!.dialCode));
  }
}
