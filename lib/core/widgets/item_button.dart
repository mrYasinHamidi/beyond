import 'package:beyond/themes/theme_extension.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';

class ItemButton extends StatelessWidget {
  final Widget? child;
  final BorderRadius? borderRadius;
  final BorderSide side;
  final BoxShape shape;
  final Color? color;
  final Color shadowColor;
  final Color? splashColor;
  final InteractiveInkFeatureFactory splashFactory;
  final double elevation;
  final EdgeInsetsGeometry margin;
  final EdgeInsetsGeometry padding;
  final VoidCallback? onTap;
  final GestureTapDownCallback? onTapDown;
  final List<BoxShadow>? shadow;
  final bool addDebounce;

  const ItemButton({
    super.key,
    this.child,
    this.addDebounce = true,
    this.onTap,
    this.borderRadius,
    this.color,
    this.side = BorderSide.none,
    this.shape = BoxShape.rectangle,
    this.shadowColor = Colors.green,
    this.elevation = 0,
    this.shadow,
    this.onTapDown,
    this.splashColor,
    this.splashFactory = InkRipple.splashFactory,
    this.padding = EdgeInsets.zero,
    this.margin = EdgeInsets.zero,
  });

  @override
  Widget build(BuildContext context) {
    final radius = borderRadius ?? BorderRadius.circular(8);
    final shapeBorder = shape == BoxShape.circle
        ? CircleBorder(side: side)
        : RoundedRectangleBorder(borderRadius: radius, side: side);

    final button = InkWell(
      onTap: () {
        if (addDebounce) {
          EasyDebounce.debounce('onTap', const Duration(milliseconds: 300), onTap ?? () {});
        } else {
          onTap?.call();
        }
      },
      onTapDown: onTapDown,
      splashFactory: splashFactory,
      borderRadius: shape == BoxShape.circle ? BorderRadius.circular(100) : radius,
      splashColor: (splashColor ?? context.theme.primaryColor).withAlpha(50),
      highlightColor: (splashColor ?? context.theme.primaryColor).withAlpha(20),
      child: Padding(padding: padding, child: child),
    );

    if (shadow == null) {
      return Card(
        shape: shapeBorder,
        color: color,
        margin: margin,
        shadowColor: shadowColor,
        elevation: elevation,
        child: button,
      );
    } else {
      return AnimatedContainer(
        decoration: BoxDecoration(boxShadow: shadow, borderRadius: radius, color: color),
        margin: margin,
        duration: const Duration(milliseconds: 250),
        child: Card(
          shape: shapeBorder,
          color: color,
          shadowColor: shadowColor,
          elevation: elevation,
          margin: EdgeInsets.zero,
          child: button,
        ),
      );
    }
  }
}
