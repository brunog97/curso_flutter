import 'package:flutter/material.dart';
import 'package:pomodoro/components/cronometro.dart';
import 'package:pomodoro/components/entrada_tempo.dart';
import 'package:pomodoro/store/pomodoro.store.dart';
import 'package:provider/provider.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class Pomodoro extends StatelessWidget {
  const Pomodoro({super.key});

  @override
  Widget build(BuildContext context) {
    final store = Provider.of<PomodoroStore>(context);

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Cronometro(),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Observer(
              builder: (_) => Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  EntradaTempo(
                    titulo: 'Trabalho',
                    valor: store.tempoTrabalho,
                    inc: store.iniciado && store.isTrabalhando()
                        ? null
                        : () {
                            store.incrementarTempo(true);
                          },
                    dec: store.iniciado && store.isTrabalhando() ||
                            store.tempoTrabalho == 1
                        ? null
                        : () {
                            store.decrementarTempo(true);
                          },
                  ),
                  EntradaTempo(
                    titulo: 'Descanso',
                    valor: store.tempoDescanso,
                    inc: store.iniciado && store.isDescansando()
                        ? null
                        : () {
                            store.incrementarTempo(false);
                          },
                    dec: store.iniciado && store.isDescansando() ||
                            store.tempoDescanso == 1
                        ? null
                        : () {
                            store.decrementarTempo(false);
                          },
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
