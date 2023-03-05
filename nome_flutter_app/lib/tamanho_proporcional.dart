import 'package:flutter/material.dart';

class TamanhoProporcional extends StatefulWidget {
  const TamanhoProporcional({super.key});

  @override
  State<TamanhoProporcional> createState() => _TamanhoProporcionalState();
}

class _TamanhoProporcionalState extends State<TamanhoProporcional> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tamanhos Proporcionais'),
      ),
      body: Column(
        children: [
          //Flexible para poder usar o FractionallySizedBox
          //Row Column não necessita de FractionallySizedBox
          //FractionallySizedBox se faz necessário quando não se deseja utilizar MEdiaQuery
          Flexible(
            child: Container(
              color: Colors.orange,
              child: FractionallySizedBox(
                widthFactor: 0.5, //50%
                heightFactor: 0.5, //50%
                alignment: Alignment.topLeft,
                child: Text('Tamanho Proporcional'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
