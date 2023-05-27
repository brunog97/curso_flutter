// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pomodoro.store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$PomodoroStore on _PomodoroStore, Store {
  late final _$tempoTrabalhoAtom =
      Atom(name: '_PomodoroStore.tempoTrabalho', context: context);

  @override
  int get tempoTrabalho {
    _$tempoTrabalhoAtom.reportRead();
    return super.tempoTrabalho;
  }

  @override
  set tempoTrabalho(int value) {
    _$tempoTrabalhoAtom.reportWrite(value, super.tempoTrabalho, () {
      super.tempoTrabalho = value;
    });
  }

  late final _$tempoDescansoAtom =
      Atom(name: '_PomodoroStore.tempoDescanso', context: context);

  @override
  int get tempoDescanso {
    _$tempoDescansoAtom.reportRead();
    return super.tempoDescanso;
  }

  @override
  set tempoDescanso(int value) {
    _$tempoDescansoAtom.reportWrite(value, super.tempoDescanso, () {
      super.tempoDescanso = value;
    });
  }

  late final _$minutosAtom =
      Atom(name: '_PomodoroStore.minutos', context: context);

  @override
  int get minutos {
    _$minutosAtom.reportRead();
    return super.minutos;
  }

  @override
  set minutos(int value) {
    _$minutosAtom.reportWrite(value, super.minutos, () {
      super.minutos = value;
    });
  }

  late final _$segundosAtom =
      Atom(name: '_PomodoroStore.segundos', context: context);

  @override
  int get segundos {
    _$segundosAtom.reportRead();
    return super.segundos;
  }

  @override
  set segundos(int value) {
    _$segundosAtom.reportWrite(value, super.segundos, () {
      super.segundos = value;
    });
  }

  late final _$_iniciadoAtom =
      Atom(name: '_PomodoroStore._iniciado', context: context);

  @override
  bool get _iniciado {
    _$_iniciadoAtom.reportRead();
    return super._iniciado;
  }

  @override
  set _iniciado(bool value) {
    _$_iniciadoAtom.reportWrite(value, super._iniciado, () {
      super._iniciado = value;
    });
  }

  late final _$tipoIntervaloAtom =
      Atom(name: '_PomodoroStore.tipoIntervalo', context: context);

  @override
  TipoIntervalo get tipoIntervalo {
    _$tipoIntervaloAtom.reportRead();
    return super.tipoIntervalo;
  }

  @override
  set tipoIntervalo(TipoIntervalo value) {
    _$tipoIntervaloAtom.reportWrite(value, super.tipoIntervalo, () {
      super.tipoIntervalo = value;
    });
  }

  late final _$_PomodoroStoreActionController =
      ActionController(name: '_PomodoroStore', context: context);

  @override
  void toogleStatusCronometro() {
    final _$actionInfo = _$_PomodoroStoreActionController.startAction(
        name: '_PomodoroStore.toogleStatusCronometro');
    try {
      return super.toogleStatusCronometro();
    } finally {
      _$_PomodoroStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void reiniciar() {
    final _$actionInfo = _$_PomodoroStoreActionController.startAction(
        name: '_PomodoroStore.reiniciar');
    try {
      return super.reiniciar();
    } finally {
      _$_PomodoroStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void incrementarTempo(bool istempoTrabalho) {
    final _$actionInfo = _$_PomodoroStoreActionController.startAction(
        name: '_PomodoroStore.incrementarTempo');
    try {
      return super.incrementarTempo(istempoTrabalho);
    } finally {
      _$_PomodoroStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void decrementarTempo(bool istempoTrabalho) {
    final _$actionInfo = _$_PomodoroStoreActionController.startAction(
        name: '_PomodoroStore.decrementarTempo');
    try {
      return super.decrementarTempo(istempoTrabalho);
    } finally {
      _$_PomodoroStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
tempoTrabalho: ${tempoTrabalho},
tempoDescanso: ${tempoDescanso},
minutos: ${minutos},
segundos: ${segundos},
tipoIntervalo: ${tipoIntervalo}
    ''';
  }
}
