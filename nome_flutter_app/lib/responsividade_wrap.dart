import 'package:flutter/material.dart';

class ResponsividadeWrap extends StatefulWidget {
  const ResponsividadeWrap({super.key});

  @override
  State<ResponsividadeWrap> createState() => _ResponsividadeWrapState();
}

class _ResponsividadeWrapState extends State<ResponsividadeWrap> {
  double altura = 100;
  double largura = 50;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wrap'),
      ),
      body: Container(
        color: Colors.black,
        width: MediaQuery.of(context)
            .size
            .width, //O container vai ocupar todo o espaço disponivel
        child: Wrap(
          alignment: WrapAlignment.center,
          //runSpacing: 10,
          children: [
            Container(
              width: largura,
              height: altura,
              color: Colors.orange,
            ),
            Container(
              width: largura,
              height: altura,
              color: Colors.pink,
            ),
            Container(
              width: largura,
              height: altura,
              color: Colors.green,
            )
          ],
        ),
      ),
    );
  }
}
