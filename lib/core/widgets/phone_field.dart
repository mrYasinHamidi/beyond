import 'package:beyond/core/utils/space_input_formatter.dart';
import 'package:beyond/themes/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class PhoneField extends StatefulWidget {
  final PhoneFieldController controller;

  const PhoneField({super.key, required this.controller});

  @override
  State<PhoneField> createState() => _PhoneFieldState();
}

class _PhoneFieldState extends State<PhoneField> {
  late final PhoneFieldController _controller = widget.controller;

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onTextChanged);
  }

  void _onTextChanged() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          bottom: 7.5,
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
            }),
          ),
        ),
        TextField(
          keyboardType: TextInputType.number,
          controller: _controller,
          decoration: InputDecoration(contentPadding: EdgeInsets.fromLTRB(0, 20, 0, 12), isDense: true),
          inputFormatters: [
            SpaceInputFormatter([3, 6]),
          ],
        ),
      ],
    );
  }
}

class PhoneFieldController extends TextEditingController {
  void setText(String rawValue) {
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

    value = TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }

  String get rawText => text.replaceAll(' ', '');
}
