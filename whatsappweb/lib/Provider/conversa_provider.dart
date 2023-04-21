import 'package:flutter/material.dart';
import 'package:whatsappweb/model/usuario.dart';

class ConversaProvider with ChangeNotifier {
  Usuario? _usuarioDestinatario;

  Usuario? get usuarioDestinatario => _usuarioDestinatario;

  set usuarioDestinatario(Usuario? usuario) {
    _usuarioDestinatario = usuario;
    notifyListeners();
  }
}
