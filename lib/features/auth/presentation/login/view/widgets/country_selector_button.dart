import 'package:beyond/features/auth/domain/entities/country/country.dart';
import 'package:flutter/material.dart';

class CountrySelectorButton extends StatelessWidget {
  final Country? selected;
  final VoidCallback? onTap;

  const CountrySelectorButton({super.key, this.selected, this.onTap});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: ValueKey(selected),
      onTap: onTap,
      decoration: InputDecoration(suffixIcon: Icon(Icons.keyboard_arrow_down_rounded)),
      initialValue: "${selected?.flag ?? ''} ${selected?.name ?? ''}",
      readOnly: true,
    );
  }
}
