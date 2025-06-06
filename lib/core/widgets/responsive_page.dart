import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

class ResponsivePage extends StatelessWidget {
  final Widget mobileView;
  final Widget tabletView;
  final Widget desktopView;

  const ResponsivePage({
    super.key,
    this.mobileView = const Placeholder(),
    this.tabletView = const Placeholder(),
    this.desktopView = const Placeholder(),
  });

  @override
  Widget build(BuildContext context) {
    return switch (ResponsiveBreakpoints.of(context).breakpoint.name) {
      MOBILE => mobileView,
      TABLET => tabletView,
      DESKTOP => desktopView,
      _ => const Placeholder(),
    };
  }
}
