import 'package:flutter/material.dart';

class DiferentesTamanhos extends StatefulWidget {
  const DiferentesTamanhos({super.key});

  @override
  State<DiferentesTamanhos> createState() => _DiferentesTamanhosState();
}

class _DiferentesTamanhosState extends State<DiferentesTamanhos> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Diferentes tamanhos'),
        ),
        //Sem o IntrinsicHeight a ROW utiliza todo o espaço disponivel.
        body: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                width: 200,
                color: Colors.orange,
                child: null,
              ),
              Container(
                width: 200,
                color: Colors.green,
                child: Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed sed ex in lacus rhoncus dictum. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae;'),
              )
            ],
          ),
        ));
  }
}
