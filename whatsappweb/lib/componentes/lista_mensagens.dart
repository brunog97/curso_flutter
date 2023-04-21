import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:whatsappweb/Provider/conversa_provider.dart';
import 'package:whatsappweb/model/conversa.dart';
import 'package:whatsappweb/model/mensagem.dart';
import 'package:whatsappweb/model/usuario.dart';
import '../util/paleta_cores.dart';

class ListaMensagens extends StatefulWidget {
  final Usuario usuarioRemetente;
  final Usuario usuarioDestinatario;

  const ListaMensagens(
      {super.key,
      required this.usuarioRemetente,
      required this.usuarioDestinatario});

  @override
  State<ListaMensagens> createState() => _ListaMensagensState();
}

class _ListaMensagensState extends State<ListaMensagens> {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  TextEditingController _controllerMensagem = TextEditingController();
  late Usuario _usuarioRemetente;
  late Usuario _usuarioDestinatario;

  StreamController _streamController =
      StreamController<QuerySnapshot>.broadcast();

  ScrollController _scrollController = ScrollController();

  late StreamSubscription _streamMensagem;
  late FocusNode _focusNode;

  _adicionarListenerMensagens() {
    final stream = _firestore
        .collection("mensagens")
        .doc(_usuarioRemetente.idUsuario)
        .collection(_usuarioDestinatario.idUsuario)
        .orderBy("data", descending: false)
        .snapshots();

    _streamMensagem = stream.listen((event) {
      _streamController.add(event);

      //equivalente ao setTimeout
      Timer(Duration(seconds: 1), () {
        //o scroll irá pro final (rodape) da lista
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      });
    });
  }

  _enviarMensagem() {
    String textoMensagem =
        _controllerMensagem.text; //Capturando o texto da mensagem

    String idUsuarioRem = _usuarioRemetente.idUsuario;
    if (textoMensagem.isNotEmpty) {
      Mensagem mensagem = Mensagem(
        idUsuarioRem,
        textoMensagem,
        Timestamp.now().toString(),
      );

      //Agora que tenho a mensagem salvo ela para o remetente
      String idUsuarioDes = _usuarioDestinatario.idUsuario;
      _salvarMensagem(idUsuarioRem, idUsuarioDes, mensagem);

      Conversa conversaRemetente = Conversa(
        idUsuarioRem,
        idUsuarioDes,
        textoMensagem,
        _usuarioDestinatario.nome,
        _usuarioDestinatario.email,
        _usuarioDestinatario.urlImagem,
      );

      _salvarConversa(conversaRemetente);

      //Agora que tenho a mensagem salvo ela para o destinatario
      _salvarMensagem(idUsuarioDes, idUsuarioRem, mensagem);

      Conversa conversaDestinatario = Conversa(
        idUsuarioDes,
        idUsuarioRem,
        textoMensagem,
        _usuarioRemetente.nome,
        _usuarioRemetente.email,
        _usuarioRemetente.urlImagem,
      );

      _salvarConversa(conversaDestinatario);
    }
  }

  _salvarConversa(Conversa conversa) {
    _firestore
        .collection("conversas")
        .doc(conversa.idRemetente)
        .collection("ultimas_mensagens")
        .doc(conversa.idDestinatario)
        .set(conversa.toMap());
  }

  _salvarMensagem(
      String idRemetente, String idDestinatario, Mensagem mensagem) {
    _firestore
        .collection("mensagens")
        .doc(idRemetente)
        .collection(idDestinatario)
        .add(mensagem.toMap());

    _controllerMensagem.clear();
  }

  _recuperaDadosIniciais() {
    _usuarioRemetente = widget.usuarioRemetente;
    _usuarioDestinatario = widget.usuarioDestinatario;

    _adicionarListenerMensagens();
  }

  _atualizarListenerMensagens() {
    Usuario? usuarioDestinatario =
        context.watch<ConversaProvider>().usuarioDestinatario;

    if (usuarioDestinatario != null) {
      _usuarioDestinatario = usuarioDestinatario;
      _recuperaDadosIniciais();
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _atualizarListenerMensagens();
  }

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _recuperaDadosIniciais();
  }

  //Cancela a escuta de mensagens
  @override
  void dispose() {
    _scrollController.dispose();
    _streamMensagem.cancel();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double largura = MediaQuery.of(context)
        .size
        .width; // Configurando a largura total do dispositivo
    return Container(
      width: largura,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("imagens/bg.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        children: [
          //Lista de mensagens
          StreamBuilder(
            stream: _streamController.stream,
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.waiting:
                  return Expanded(
                    child: Center(
                      child: Column(children: [
                        Text('Carregando mensagens'),
                        CircularProgressIndicator(),
                      ]),
                    ),
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
                    QuerySnapshot querySnapshot =
                        snapshot.data as QuerySnapshot;

                    List<DocumentSnapshot> listaMensagens =
                        querySnapshot.docs.toList();

                    return Expanded(
                      child: ListView.builder(
                        controller: _scrollController,
                        itemCount: listaMensagens.length,
                        itemBuilder: ((context, index) {
                          DocumentSnapshot item = listaMensagens[index];

                          Alignment alinhamento = Alignment.bottomLeft;
                          Color color = Colors.white;

                          if (_usuarioRemetente.idUsuario ==
                              item["idUsuario"].toString()) {
                            alinhamento = Alignment.bottomRight;
                            color = Color(0xffd2ffa5);
                          }

                          Size largura =
                              MediaQuery.of(context).size * 0.8; // 80% da tela

                          return Align(
                            alignment: alinhamento,
                            child: Container(
                              //definindo que esse container só pode ter no maximo essa largura e se for menor fica menor
                              constraints: BoxConstraints.loose(largura),
                              //width: largura,
                              decoration: BoxDecoration(
                                color: color,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(8),
                                ),
                              ),
                              padding: EdgeInsets.all(16),
                              margin: EdgeInsets.all(1),
                              child: Text(item["texto"].toString()),
                            ),
                          );
                        }),
                      ),
                    );
                  }
              }
            },
          ),
          //Caixa de texto
          Container(
            padding: EdgeInsets.all(8),
            color: PaletaCores.corFundoBarra,
            child: Row(
              children: [
                //Caixa de texto arredondada
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 8,
                    ),
                    margin: EdgeInsets.symmetric(
                      horizontal: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.insert_emoticon),
                        SizedBox(
                          width: 4,
                        ),
                        Expanded(
                          child: RawKeyboardListener(
                            focusNode: FocusNode(),
                            onKey: (event) {
                              //print(event.data.logicalKey.keyId);
                              if (event.runtimeType == RawKeyDownEvent &&
                                  (event.logicalKey.keyId == 54)) {
                                _enviarMensagem();
                                _focusNode
                                    .requestFocus(); // devolvendo o focus pro textField
                              }
                            },
                            child: TextField(
                              focusNode: _focusNode,
                              autofocus: true,
                              controller: _controllerMensagem,
                              onSubmitted: (value) {
                                _enviarMensagem();
                                _focusNode
                                    .requestFocus(); // devolvendo o focus pro textField
                              },
                              decoration: InputDecoration(
                                hintText: "Digite uma mensagem",
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ),
                        Icon(Icons.attach_file),
                        Icon(Icons.camera_alt)
                      ],
                    ),
                  ),
                ),
                //Botao Enviar mensagem
                FloatingActionButton(
                  backgroundColor: Color(0xff075E54),
                  onPressed: () {
                    _enviarMensagem();
                    _focusNode.requestFocus();
                  },
                  mini: true,
                  child: Icon(
                    Icons.send,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
