import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:whatsappweb/model/usuario.dart';

class ListaContatos extends StatefulWidget {
  const ListaContatos({super.key});

  @override
  State<ListaContatos> createState() => _ListaContatosState();
}

class _ListaContatosState extends State<ListaContatos> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late String _idUsuarioLogado;

  Future<List<Usuario>> _recuperarContatos() async {
    final usuarioRef = _firestore.collection("usuarios");
    QuerySnapshot querySnapshot = await usuarioRef.get();
    List<Usuario> listaUsuarios = [];

    for (DocumentSnapshot item in querySnapshot.docs) {
      String idUsuario = item["idUsuario"];
      String email = item["email"];
      String nome = item["nome"];
      String urlImagem = item["urlImagem"];

      // pula o usuario logado na lista
      if (idUsuario == _idUsuarioLogado) {
        continue;
      }

      Usuario usuario = Usuario(
        idUsuario,
        nome,
        email,
        urlImagem: urlImagem,
      );

      listaUsuarios.add(usuario);
    }

    print(listaUsuarios);

    return listaUsuarios;
  }

  _recuperarDadosUsuarioLogado() {
    User? usuarioAtual = _auth.currentUser;

    if (usuarioAtual != null) {
      _idUsuarioLogado = usuarioAtual.uid;
    }
  }

  @override
  void initState() {
    super.initState();
    _recuperarDadosUsuarioLogado();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Usuario>>(
      future: _recuperarContatos(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return Container();
          case ConnectionState.waiting:
            return Center(
              child: Column(children: [
                Text('Carregando Contatos'),
                CircularProgressIndicator(),
              ]),
            );
          case ConnectionState.active:
            return Container();
          case ConnectionState.done:
            if (snapshot.hasError) {
              return Center(
                child: Text("Ocorreu um erro ao carregar os dados"),
              );
            } else {
              List<Usuario>? listaUsuarios = snapshot.data;

              if (listaUsuarios!.isNotEmpty) {
                return ListView.separated(
                  itemBuilder: (context, index) {
                    Usuario usuario = listaUsuarios[index];
                    return ListTile(
                      onTap: () {
                        Navigator.pushNamed(context, "/mensagens",
                            arguments: usuario);
                      },
                      leading: CircleAvatar(
                        radius: 25,
                        backgroundColor: Colors.grey,
                        backgroundImage:
                            CachedNetworkImageProvider(usuario.urlImagem),
                      ),
                      contentPadding: EdgeInsets.all(8),
                      title: Text(
                        usuario.nome,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return Divider(
                      color: Colors.grey,
                      thickness: 0.2,
                    );
                  },
                  itemCount: listaUsuarios.length,
                );
              }

              return Center(
                child: Text("Voce não possui contatos cadastrados!"),
              );
            }
        }
      },
    );
  }
}
