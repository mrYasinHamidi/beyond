import 'package:flutter/services.dart';

class FixedPrefixFormatter extends TextInputFormatter {
  final String prefix;

  FixedPrefixFormatter(this.prefix);

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    if (!newValue.text.startsWith(prefix)) {
      return oldValue;
    }
    final selectionIndex = newValue.selection.baseOffset;
    if (selectionIndex < prefix.length) {
      return oldValue;
    }
    return newValue;
  }
}
