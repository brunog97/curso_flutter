import 'package:flutter/material.dart';
// import 'package:pomodoro/store/pomodoro.store.dart';
// import 'package:provider/provider.dart';

class CronometroBotao extends StatelessWidget {
  final String texto;
  final IconData icone;
  final void Function()? clique;

  const CronometroBotao({
    super.key,
    required this.texto,
    required this.icone,
    this.clique,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.black,
        padding: EdgeInsets.symmetric(
          horizontal: 30,
          vertical: 20,
        ),
        textStyle: TextStyle(
          fontSize: 25,
        ),
      ),
      onPressed: clique,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: Icon(
              icone,
              size: 35,
            ),
          ),
          Text(texto)
        ],
      ),
    );
  }
}
