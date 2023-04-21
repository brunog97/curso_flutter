import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whatsappweb/Provider/conversa_provider.dart';
import 'package:whatsappweb/model/conversa.dart';
import 'package:whatsappweb/model/usuario.dart';

import '../util/responsivo.dart';

class ListaConversas extends StatefulWidget {
  const ListaConversas({super.key});

  @override
  State<ListaConversas> createState() => _ListaConversasState();
}

class _ListaConversasState extends State<ListaConversas> {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  FirebaseAuth _auth = FirebaseAuth.instance;

  late Usuario _usuarioRemetente;

  StreamController _streamController =
      StreamController<QuerySnapshot>.broadcast();

  late StreamSubscription _streamConversas;

  _recuperarDadosIniciais() {
    User? userLogado = _auth.currentUser;

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

    _adicionarListenerConversa();
  }

  _adicionarListenerConversa() {
    final stream = _firestore
        .collection("conversas")
        .doc(_usuarioRemetente.idUsuario)
        .collection("ultimas_mensagens")
        .snapshots();

    _streamConversas = stream.listen((event) {
      _streamController.add(event);
    });
  }

  @override
  void initState() {
    super.initState();
    _recuperarDadosIniciais();
  }

  @override
  void dispose() {
    super.dispose();
    _streamConversas.cancel();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsivo.isMobile(context);

    return StreamBuilder(
      stream: _streamController.stream,
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return Center(
              child: Column(children: [
                Text('Carregando conversas'),
                CircularProgressIndicator(),
              ]),
            );
          case ConnectionState.active:
          case ConnectionState.done:
            if (snapshot.hasError) {
              return Expanded(
                child: Center(
                  child: Text('Erro ao carregar...'),
                ),
              );
            } else {
              QuerySnapshot querySnapshot = snapshot.data as QuerySnapshot;

              List<DocumentSnapshot> listaConversas =
                  querySnapshot.docs.toList();

              return ListView.separated(
                itemBuilder: (context, index) {
                  DocumentSnapshot conversa = listaConversas[index];

                  Conversa conversaItem = Conversa(
                    conversa["idRemetente"],
                    conversa["idDestinatario"],
                    conversa["ultimaMensagem"],
                    conversa["nomeDestinatario"],
                    conversa["emailDestinatario"],
                    conversa["urlImagemDestinatario"],
                  );

                  Usuario usuario = Usuario(
                    conversaItem.idDestinatario,
                    conversaItem.nomeDestinatario,
                    conversaItem.emailDestinatario,
                    urlImagem: conversaItem.urlImagemDestinatario,
                  );

                  return ListTile(
                    onTap: () {
                      if (isMobile) {
                        Navigator.pushNamed(context, "/mensagens",
                            arguments: usuario);
                      } else {
                        context.read<ConversaProvider>().usuarioDestinatario =
                            usuario;
                      }
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
                    subtitle: Text(
                      conversaItem.ultimaMensagem,
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis, //...
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return Divider(
                    color: Colors.grey,
                    thickness: 0.2,
                  );
                },
                itemCount: listaConversas.length,
              );
            }
        }
      },
    );
  }
}
