import 'package:flutter/material.dart';

class Responsivo extends StatelessWidget {
  final Widget mobile;
  final Widget? tablet;
  final Widget desktop;

  const Responsivo({
    super.key,
    required this.mobile,
    required this.desktop,
    this.tablet,
  });

  static bool isMobile(BuildContext context) {
    return MediaQuery.of(context).size.width < 800;
  }

  static bool isTablet(BuildContext context) {
    return MediaQuery.of(context).size.width >= 800 &&
        MediaQuery.of(context).size.width < 1200;
  }

  static bool isDesktop(BuildContext context) {
    return MediaQuery.of(context).size.width >= 1200;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth >= 1200) {
        return desktop;
      } else if (constraints.maxWidth >= 800) {
        Widget? temTablet = tablet;
        if (temTablet != null) {
          return temTablet;
        } else {
          return mobile;
        }
      } else {
        return mobile;
      }
    });
  }
}
