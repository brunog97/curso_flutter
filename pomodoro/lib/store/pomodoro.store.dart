import 'dart:async';

import 'package:mobx/mobx.dart';

part 'pomodoro.store.g.dart';

class PomodoroStore = _PomodoroStore with _$PomodoroStore;

enum TipoIntervalo { trabalho, descanso }

abstract class _PomodoroStore with Store {
  @observable
  int tempoTrabalho = 2;
  @observable
  int tempoDescanso = 1;

  @observable
  int minutos = 2;

  @observable
  int segundos = 0;

  @observable
  bool _iniciado = false;

  @observable
  TipoIntervalo tipoIntervalo = TipoIntervalo.trabalho;

  //@observable
  bool isTrabalhando() {
    return tipoIntervalo == TipoIntervalo.trabalho;
  }

  //@observable
  bool isDescansando() {
    return tipoIntervalo == TipoIntervalo.descanso;
  }

  bool get iniciado {
    return _iniciado;
  }

  Timer? cronometro;

  @action
  void toogleStatusCronometro() {
    _iniciado = !_iniciado;
    if (_iniciado) {
      //alternar para seconds no Duration depois / pra testar usar milliseconds
      cronometro = Timer.periodic(Duration(seconds: 1), (timer) {
        //decrementar os segundos
        if (minutos == 0 && segundos == 0) {
          _trocarIntervalo();
          print('Entrei nessa porra');
        } else if (segundos == 0) {
          segundos = 59;
          minutos--;
        } else {
          segundos--;
        }
      });
    } else {
      cronometro?.cancel();
    }
  }

  @action
  void reiniciar() {
    _iniciado = false;
    cronometro?.cancel();
    minutos = isTrabalhando() ? tempoTrabalho : tempoDescanso;
    segundos = 0;
  }

  // precisa corrigir o bug de parar o que está em execução
  @action
  void incrementarTempo(bool istempoTrabalho) {
    if (istempoTrabalho) {
      tempoTrabalho++;
      //reiniciar();
    } else {
      tempoDescanso++;
      //reiniciar();
    }
  }

  @action
  void decrementarTempo(bool istempoTrabalho) {
    if (istempoTrabalho) {
      if (tempoTrabalho > 1) {
        tempoTrabalho--;
      }

      //reiniciar();
    } else {
      if (tempoDescanso > 1) {
        tempoDescanso--;
      }
      //reiniciar();
    }
  }

  void _trocarIntervalo() {
    if (isTrabalhando()) {
      tipoIntervalo = TipoIntervalo.descanso;
      minutos = tempoDescanso;
    } else {
      tipoIntervalo = TipoIntervalo.trabalho;
      minutos = tempoTrabalho;
    }

    segundos = 0;
  }
}
