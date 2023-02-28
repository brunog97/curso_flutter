import 'package:flutter/material.dart';

class Resposta extends StatelessWidget {
  final String texto;

  final void Function() onSelecao;

  const Resposta(this.texto, this.onSelecao, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 2.5, 2.5, 10),
      width: double.infinity,
      child: TextButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          backgroundColor: MaterialStateProperty.all(Colors.blue[300]), //color
          foregroundColor: MaterialStateProperty.all(Colors.white), //textColor
        ),
        onPressed: onSelecao,
        child: Text(texto),
      ),
    );
  }
}
