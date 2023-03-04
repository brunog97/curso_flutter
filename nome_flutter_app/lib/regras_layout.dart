import 'package:flutter/material.dart';

class RegrasLayout extends StatefulWidget {
  const RegrasLayout({super.key});

  @override
  State<RegrasLayout> createState() => _RegrasLayoutState();
}

class _RegrasLayoutState extends State<RegrasLayout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Layout Builder'),
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Colors.orange,
          child: LayoutBuilder(builder: (context, constraint) {
            var largura = constraint.maxWidth;
            print('largura: $largura');

            if (largura < 600) {
              //celular
              return Text('Celulares');
            } else if (largura < 960) {
              // celulares maiores e tabletes
              return Text('Celulares maiores e/ou tablets');
            } else {
              return Text('Telas Maiores');
            }
          }),
        ));
  }
}
