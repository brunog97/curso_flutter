import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:whatsappweb/componentes/lista_mensagens.dart';
import 'package:whatsappweb/model/usuario.dart';

class Mensagens extends StatefulWidget {
  final Usuario usuarioDestinatario;

  const Mensagens(this.usuarioDestinatario);

  @override
  State<Mensagens> createState() => _MensagensState();
}

class _MensagensState extends State<Mensagens> {
  late Usuario _usuarioRemetente;
  late Usuario _usuarioDestinatario;

  FirebaseAuth _auth = FirebaseAuth.instance;

  _recuperarDadosIniciais() {
    User? userLogado = _auth.currentUser;
    _usuarioDestinatario = widget.usuarioDestinatario;

    if (userLogado != null) {
      String idUsuario = userLogado.uid;
      String? nome = userLogado.displayName ?? "";
      String? email = userLogado.email ?? "";
      String? urlImagem = userLogado.photoURL ?? "";

      _usuarioRemetente = Usuario(
        idUsuario,
        nome,
        email,
        urlImagem: urlImagem,
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _recuperarDadosIniciais();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(children: [
          CircleAvatar(
            radius: 25,
            backgroundColor: Colors.grey,
            backgroundImage: CachedNetworkImageProvider(
              _usuarioDestinatario.urlImagem,
            ),
          ),
          SizedBox(
            width: 8,
          ),
          Text(
            _usuarioDestinatario.nome,
            style: TextStyle(color: Colors.white, fontSize: 16),
          )
        ]),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.more_vert),
          ),
        ],
      ),
      //SafeArea ajuda pra usuarios de iPhone
      body: SafeArea(
        child: ListaMensagens(
          usuarioRemetente: _usuarioRemetente,
          usuarioDestinatario: _usuarioDestinatario,
        ),
      ),
    );
  }
}
