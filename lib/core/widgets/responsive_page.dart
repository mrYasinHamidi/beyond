import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

class ResponsivePage extends StatelessWidget {
  final Widget mobileView;
  final Widget tabletView;
  final Widget desktopView;
  final bool useMobileForAll;

  const ResponsivePage({
    super.key,
    this.mobileView = const Placeholder(),
    this.tabletView = const Placeholder(),
    this.desktopView = const Placeholder(),
    this.useMobileForAll = true,
  });

  @override
  Widget build(BuildContext context) {
    if (useMobileForAll) {
      final mobileWidth = ResponsiveBreakpoints.of(
        context,
      ).breakpoints.firstWhere((element) => element.name == MOBILE).end;
      final currentWidth = ResponsiveBreakpoints.of(context).screenWidth;
      return Material(
        child: Align(
          alignment: Alignment.center,
          child: SizedBox(width: currentWidth > mobileWidth ? mobileWidth : currentWidth, child: mobileView),
        ),
      );
    }
    return switch (ResponsiveBreakpoints.of(context).breakpoint.name) {
      MOBILE => mobileView,
      TABLET => tabletView,
      DESKTOP => desktopView,
      _ => const Placeholder(),
    };
  }
}
