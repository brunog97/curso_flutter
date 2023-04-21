import 'package:flutter/material.dart';

class Responsivo extends StatelessWidget {
  final Widget mobile;
  final Widget? tablet;
  final Widget web;

  const Responsivo({
    super.key,
    required this.mobile,
    required this.web,
    this.tablet,
  });

  static bool isMobile(BuildContext context) {
    return MediaQuery.of(context).size.width < 800;
  }

  static bool isTablet(BuildContext context) {
    return MediaQuery.of(context).size.width >= 800 &&
        MediaQuery.of(context).size.width < 1200;
  }

  static bool isWeb(BuildContext context) {
    return MediaQuery.of(context).size.width >= 1200;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraits) {
      if (constraits.maxWidth >= 1200) {
        return web;
      } else if (constraits.maxWidth >= 800) {
        Widget? resTablet = tablet;
        if (resTablet != null) {
          return resTablet;
        } else {
          return web;
        }
      } else {
        return mobile;
      }

      //throw 'Responsividade não disponivel!';
      //O trhow deveria ser lançado se eu nao passasse o web para quando o tablet e nulo
    });
  }
}
