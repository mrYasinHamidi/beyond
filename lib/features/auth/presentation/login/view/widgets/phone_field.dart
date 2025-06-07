import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PhoneField extends StatelessWidget {
  const PhoneField({super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.number,
      maxLength: 11, //  e.g. “091 234 56789”
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly, //  keep digits only
        _ThreeDigitSpaceFormatter(), //  add 1 space / 3 digits
      ],
      decoration: const InputDecoration(
        counterText: '',
        //  hide default counter
        hintText: '___ ___ _____',
        //  11 slots → 3-3-5
        hintStyle: TextStyle(
          decoration: TextDecoration.underline, //  underline the hint
          letterSpacing: 2, //  make underscores breathe
        ),
        border: UnderlineInputBorder(),
        //  normal TextField underline
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(width: 2), //  thicker when focused
        ),
      ),
    );
  }
}

class _ThreeDigitSpaceFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    // Strip every space in the raw input.
    final digits = newValue.text.replaceAll(' ', '');
    final sb = StringBuffer();

    for (var i = 0; i < digits.length; i++) {
      sb.write(digits[i]);
      // Add a space after each third digit *unless* it’s the last char.
      if ((i + 1) % 3 == 0 && i + 1 != digits.length) sb.write(' ');
    }

    // Keep the cursor at the end of the string we just built.
    return TextEditingValue(
      text: sb.toString(),
      selection: TextSelection.collapsed(offset: sb.length),
    );
  }
}
