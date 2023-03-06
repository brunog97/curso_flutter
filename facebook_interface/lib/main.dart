import 'package:facebook_interface/telas/principal.dart';
import 'package:facebook_interface/uteis/paleta_cores.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      title: "Facebook",
      //debugShowCheckedModeBanner: remove o banner vermelho "DEBUG"
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: PaletaCores.scaffold,
      ),
      home: Principal(),
    ),
  );
}
