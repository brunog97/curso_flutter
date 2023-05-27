import 'package:mobx/mobx.dart';
//Arquivo criado automaticamente
part 'contador.store.g.dart';
//_$ContadorStore será criado

class ContadorStore = _ContadorStore with _$ContadorStore;

abstract class _ContadorStore with Store {
  @observable
  int contador = 0;

  @action
  void incrementar() {
    contador++;
  }
}


/*
Necessario gerar o observable com o build_runner e o mobx_codegen 
flutter pub run build_runner --help // ver comandos
flutter pub run build_runner clean // limpar
flutter pub run build_runner watch // ciar e ficar assistindo mudanças. 
 

if it dont works try dart run
if it doesn't works try dart run


*/