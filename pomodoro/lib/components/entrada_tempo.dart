import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:pomodoro/store/pomodoro.store.dart';
import 'package:provider/provider.dart';

class EntradaTempo extends StatelessWidget {
  final String titulo;
  final int valor;
  final void Function()? inc;
  final void Function()? dec;

  const EntradaTempo({
    super.key,
    required this.titulo,
    required this.valor,
    this.inc,
    this.dec,
  });

  @override
  Widget build(BuildContext context) {
    final store = Provider.of<PomodoroStore>(context);

    return Observer(
      builder: (context) => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            titulo,
            style: TextStyle(
              fontSize: 25,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: dec,
                style: ElevatedButton.styleFrom(
                  shape: CircleBorder(),
                  padding: EdgeInsets.all(15),
                  backgroundColor:
                      store.isTrabalhando() ? Colors.red : Colors.green,
                ),
                child: Icon(
                  Icons.arrow_downward,
                  color: Colors.white,
                ),
              ),
              Text(
                '$valor min',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              ElevatedButton(
                onPressed: inc,
                style: ElevatedButton.styleFrom(
                  shape: CircleBorder(),
                  padding: EdgeInsets.all(15),
                  backgroundColor:
                      store.isTrabalhando() ? Colors.red : Colors.green,
                ),
                child: Icon(
                  Icons.arrow_upward,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
