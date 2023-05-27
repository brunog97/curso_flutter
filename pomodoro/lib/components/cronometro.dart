import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:pomodoro/components/cronometro_botao.dart';
import 'package:pomodoro/store/pomodoro.store.dart';
import 'package:provider/provider.dart';

class Cronometro extends StatelessWidget {
  const Cronometro({super.key});

  @override
  Widget build(BuildContext context) {
    final store = Provider.of<PomodoroStore>(context);
    return Observer(
      builder: (context) => Container(
        color: store.isTrabalhando() ? Colors.red : Colors.green,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              store.isTrabalhando() ? 'Hora de Trabalhar' : 'Hora de Descansar',
              style: TextStyle(
                fontSize: 40,
                color: Colors.white,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              '${store.minutos.toString().padLeft(2, '0')}:${store.segundos.toString().padRight(2, '0')}',
              style: TextStyle(fontSize: 120, color: Colors.white),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (!store.iniciado)
                  Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: CronometroBotao(
                      texto: 'Iniciar',
                      icone: Icons.play_arrow,
                      clique: store.toogleStatusCronometro,
                    ),
                  ),
                if (store.iniciado)
                  Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: CronometroBotao(
                      texto: 'Parar',
                      icone: Icons.stop,
                      clique: store.toogleStatusCronometro,
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: CronometroBotao(
                    texto: 'Reiniciar',
                    icone: Icons.refresh,
                    clique: store.reiniciar,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
