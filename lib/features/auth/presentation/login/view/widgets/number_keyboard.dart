import 'dart:ffi';

import 'package:beyond/core/widgets/item_button.dart';
import 'package:beyond/themes/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class NumberKeyboard extends StatelessWidget {
  final Function(Char number) onTapNumber;

  const NumberKeyboard({super.key, required this.onTapNumber});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(child: _Button(number: 1)),
              Gap(8),
              Expanded(child: _Button(number: 2)),
              Gap(8),
              Expanded(child: _Button(number: 3)),
            ],
          ),
        ),
        Gap(8),
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(child: _Button(number: 4)),
              Gap(8),
              Expanded(child: _Button(number: 5)),
              Gap(8),
              Expanded(child: _Button(number: 6)),
            ],
          ),
        ),
        Gap(8),
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(child: _Button(number: 7)),
              Gap(8),
              Expanded(child: _Button(number: 8)),
              Gap(8),
              Expanded(child: _Button(number: 9)),
            ],
          ),
        ),
        Gap(8),
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Spacer(),
              Gap(8),
              Expanded(child: _Button(number: 0)),
              Gap(8),
              Expanded(child: _Button()),
            ],
          ),
        ),
      ],
    );
  }
}

class _Button extends StatelessWidget {
  final int? number;
  final VoidCallback? onTap;

  const _Button({super.key, this.number, this.onTap});

  @override
  Widget build(BuildContext context) {
    return ItemButton(
      color: context.theme.scaffoldBackgroundColor.withAlpha(50),
      splashFactory: InkSparkle.splashFactory,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          number != null
              ? Padding(
                  padding: const EdgeInsetsDirectional.only(start: 16),
                  child: Text('$number', style: TextStyle(fontSize: 24), textAlign: TextAlign.center),
                )
              : Icon(Icons.backspace_outlined),
          if (hint != null)
            Expanded(
              flex: 3,
              child: Text(
                hint!,
                textAlign: TextAlign.center,
                style: TextStyle(color: context.theme.colorScheme.onSurface.withAlpha(200)),
              ),
            ),
        ],
      ),
    );
  }

  String? get hint => switch (number) {
    0 => '+',
    1 => '',
    2 => 'ABC',
    3 => 'DEF',
    4 => 'GHI',
    5 => 'JKL',
    6 => 'MNO',
    7 => 'PORS',
    8 => 'TUV',
    9 => 'WXYZ',
    _ => null,
  };
}
