import 'package:flutter/material.dart';

class ResponsividadeMediaQuery extends StatefulWidget {
  const ResponsividadeMediaQuery({Key? key}) : super(key: key);

  @override
  State<ResponsividadeMediaQuery> createState() =>
      _ResponsividadeMediaQueryState();
}

class _ResponsividadeMediaQueryState extends State<ResponsividadeMediaQuery> {
  @override
  Widget build(BuildContext context) {
    var height =
        MediaQuery.of(context).size.height; //Altura total do dispositivo
    var width =
        MediaQuery.of(context).size.width; //Largura total do dispositivo

    var heightStatusBar = MediaQuery.of(context)
        .padding
        .top; //espaçamento da barra de status dispositivo movel
    var heightAppBar = AppBar().preferredSize.height; //espaçamento da AppBar

    var widthItem = width / 3; //25% do espaço total

    return Scaffold(
        appBar: AppBar(
          title: const Text('Aulas de Responsividade'),
        ),
        body: Row(
          // crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: height - heightAppBar - heightStatusBar,
              //width: width/ 2,  //50% do espaço total
              width: widthItem,
              color: Colors.deepOrange,
              child: Text('Responsividade teste'),
            ),
            Container(
              height: height - heightAppBar - heightStatusBar,
              //width: width/ 2,  //50% do espaço total
              width: widthItem,
              color: Colors.deepPurple,
              child: Text('Responsividade teste'),
            ),
            Container(
              height: height - heightAppBar - heightStatusBar,
              //width: width/ 2,  //50% do espaço total
              width: widthItem,
              color: Colors.yellow,
              child: Text('Responsividade teste'),
            ),
          ],
        ));
  }
}
