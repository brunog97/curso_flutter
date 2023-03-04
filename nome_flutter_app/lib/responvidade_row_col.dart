import 'package:flutter/material.dart';

class ResponsividadeRowCol extends StatefulWidget {
  const ResponsividadeRowCol({super.key});

  @override
  State<ResponsividadeRowCol> createState() => _ResponsividadeRowColState();
}

class _ResponsividadeRowColState extends State<ResponsividadeRowCol> {
  @override
  Widget build(BuildContext context) {
    var height =
        MediaQuery.of(context).size.height; //Altura total do dispositivo
    var width =
        MediaQuery.of(context).size.width; //Largura total do dispositivo
    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        title: Text('Responsividade'),
      ),
      body: Column(
        children: [
          // Container(
          //   color: Colors.red,
          //   height: 200,
          // ),
          //Expanded sempre utiliza todo espaço disponivel quando mais de um ele divide automaticamente
          Expanded(
            flex: 2,
            child: Container(
              color: Colors.red,
            ),
          ),
          Expanded(
            flex: 6,
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    color: Colors.purple,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    color: Colors.orange,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    color: Colors.yellow,
                  ),
                )
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              color: Colors.pink,
            ),
          ),
        ],
      ),
    );
  }
}
