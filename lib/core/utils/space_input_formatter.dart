import 'package:flutter/services.dart';

class SpaceInputFormatter extends TextInputFormatter {
  final List<int> spaceIndexes;

  SpaceInputFormatter(this.spaceIndexes);

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    String rawText = newValue.text.replaceAll(' ', '');

    StringBuffer formatted = StringBuffer();
    int rawIndex = 0;

    for (int i = 0; i < rawText.length; i++) {
      if (spaceIndexes.contains(rawIndex)) {
        formatted.write(' ');
      }
      formatted.write(rawText[i]);

      rawIndex++;
    }

    int newOffset = formatted.length;
    return TextEditingValue(
      text: formatted.toString(),
      selection: TextSelection.collapsed(offset: newOffset),
    );
  }
}
