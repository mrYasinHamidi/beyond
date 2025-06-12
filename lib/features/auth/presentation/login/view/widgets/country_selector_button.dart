import 'package:beyond/features/auth/domain/entities/country/country.dart';
import 'package:flutter/material.dart';

class CountrySelectorButton extends StatelessWidget {
  final Country? selected;

  const CountrySelectorButton({super.key, this.selected});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: ValueKey(selected),
      decoration: InputDecoration(suffixIcon: Icon(Icons.keyboard_arrow_down_rounded)),
      initialValue: "${selected?.flag ?? ''} ${selected?.name ?? ''}",
      readOnly: true,
    );
  }
}
