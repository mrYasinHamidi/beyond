import 'package:flutter/material.dart';

class CountrySelectorButton extends StatelessWidget {
  const CountrySelectorButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(suffixIcon: Icon(Icons.keyboard_arrow_down_rounded)),
      initialValue: 'Iran',
      readOnly: true,
    );
  }
}
