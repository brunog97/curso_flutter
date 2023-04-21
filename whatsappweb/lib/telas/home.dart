import 'package:flutter/material.dart';
import 'package:whatsappweb/telas/home_mobile.dart';
import 'package:whatsappweb/telas/home_web.dart';

import '../util/responsivo.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Responsivo(
      mobile: HomeMobile(),
      tablet: HomeWeb(),
      web: HomeWeb(),
    );
  }
}
