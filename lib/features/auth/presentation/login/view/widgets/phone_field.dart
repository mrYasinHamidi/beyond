import 'package:beyond/themes/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import 'package:flutter/services.dart';

class PhoneField extends StatefulWidget {
  final PhoneFieldController controller;

  const PhoneField({super.key, required this.controller});

  @override
  State<PhoneField> createState() => _PhoneFieldState();
}

class _PhoneFieldState extends State<PhoneField> {
  late final PhoneFieldController _controller = widget.controller;
  TextSelection _lastSelection = const TextSelection.collapsed(offset: -1);
  String _lastText = '';
  bool _isProgrammaticChange = false;

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onTextChanged);
  }

  void _onTextChanged() {
    final currentText = _controller.text;
    final currentSelection = _controller.selection;

    // Avoid reacting to programmatic changes
    if (_isProgrammaticChange) {
      _isProgrammaticChange = false;
      _lastText = currentText;
      _lastSelection = currentSelection;
      return;
    }

    final oldText = _lastText;
    final oldSelection = _lastSelection;

    // Compare lengths
    if (currentText.length > oldText.length) {
      final insertedText = currentText.replaceFirst(oldText, '');
      final index = oldSelection.baseOffset;
      print('Inserted "$insertedText" at index $index');
    } else if (currentText.length < oldText.length) {
      final removedCount = oldText.length - currentText.length;
      final index = oldSelection.baseOffset;
      print('Backspace/Delete of $removedCount characters at index $index');
    } else {
      print('No length change. Maybe selection moved.');
    }

    // Save state for next comparison
    _lastText = currentText;
    _lastSelection = currentSelection;
    setState(() {});
  }

  void _setProgrammaticText(String rawValue) {
    String formatWithCustomSpaces(String raw, List<int> spaceIndexes) {
      final buffer = StringBuffer();
      int rawIndex = 0;

      for (int i = 0; i < raw.length; i++) {
        if (spaceIndexes.contains(rawIndex)) {
          buffer.write(' ');
        }
        buffer.write(raw[i]);
        rawIndex++;
      }

      return buffer.toString();
    }

    final formattedText = formatWithCustomSpaces(rawValue, [3, 6]);

    _isProgrammaticChange = true;

    _controller.value = TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        TextField(
          keyboardType: TextInputType.number,
          controller: _controller,

          inputFormatters: [
            CustomSpaceInputFormatter([3, 6]),
          ],
        ),
        Positioned(
          bottom: 9,
          left: 0,
          child: Row(
            children: List.generate(12, (index) {
              if (index == 3 || index == 7) {
                return Gap(6);
              }
              return Text(
                '0',
                style: context.theme.textTheme.titleMedium?.copyWith(
                  color: context.theme.colorScheme.onSurface.withAlpha(index < _controller.text.length ? 0 : 100),
                ),
              );
              return Gap(0);
            }),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _controller.removeListener(_onTextChanged);
    _controller.dispose();
    super.dispose();
  }
}

class PhoneFieldController extends TextEditingController {
  @override
  String get text => value.text.replaceAll(' ', '');

  @override
  set text(String newText) {
    value = value.copyWith(
      text: newText,
      selection: const TextSelection.collapsed(offset: -1),
      composing: TextRange.empty,
    );
  }
}

class CustomSpaceInputFormatter extends TextInputFormatter {
  final List<int> spaceIndexes;

  CustomSpaceInputFormatter(this.spaceIndexes);

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    // Step 1: Remove existing spaces
    String rawText = newValue.text.replaceAll(' ', '');

    // Step 2: Insert spaces at custom indexes
    StringBuffer formatted = StringBuffer();
    int rawIndex = 0;

    for (int i = 0; i < rawText.length; i++) {
      if (spaceIndexes.contains(rawIndex)) {
        formatted.write(' ');
      }
      formatted.write(rawText[i]);
      rawIndex++;
    }

    // Step 3: Adjust cursor position
    int newOffset = formatted.length;
    return TextEditingValue(
      text: formatted.toString(),
      selection: TextSelection.collapsed(offset: newOffset),
    );
  }
}
