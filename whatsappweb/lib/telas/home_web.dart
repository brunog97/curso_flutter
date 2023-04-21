import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whatsappweb/Provider/conversa_provider.dart';
import 'package:whatsappweb/componentes/lista_conversas.dart';
import 'package:whatsappweb/componentes/lista_mensagens.dart';
import 'package:whatsappweb/model/usuario.dart';
import 'package:whatsappweb/util/paleta_cores.dart';
import 'package:whatsappweb/util/responsivo.dart';

class HomeWeb extends StatefulWidget {
  const HomeWeb({super.key});

  @override
  State<HomeWeb> createState() => _HomeWebState();
}

class _HomeWebState extends State<HomeWeb> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  late Usuario _usuarioLogado;

  _recuperarDadosUsuarioLogado() {
    User? userLogado = _auth.currentUser;

    if (userLogado != null) {
      String idUsuario = userLogado.uid;
      String? nome = userLogado.displayName ?? "";
      String? email = userLogado.email ?? "";
      String? urlImagem = userLogado.photoURL ?? "";

      _usuarioLogado = Usuario(
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
    _recuperarDadosUsuarioLogado();
  }

  @override
  Widget build(BuildContext context) {
    final largura = MediaQuery.of(context).size.width;
    final altura = MediaQuery.of(context).size.height;
    final isWeb = Responsivo.isWeb(context);

    return Scaffold(
      body: Container(
        color: PaletaCores.corFundo,
        child: Stack(
          children: [
            Positioned(
              top: 0, // necessario pra não dar problema de overflow.
              child: Container(
                color: PaletaCores.corPrimaria,
                width: largura,
                height: altura * 0.2,
              ),
            ),
            Positioned(
                top: isWeb ? altura * 0.05 : 0,
                bottom: isWeb ? altura * 0.05 : 0,
                left: isWeb ? largura * 0.05 : 0,
                right: isWeb ? largura * 0.05 : 0,
                //ROW CONTEUDO DO LADO DO OUTRO
                //COLUMN CONTEUDO UM EMBAIXO DO OUTRO
                child: Row(
                  children: [
                    Expanded(
                      flex: 4,
                      child: AreaLateralConversas(
                        usuarioLogado: _usuarioLogado,
                      ),
                    ),
                    Expanded(
                      flex: 10,
                      child: AreaLateralMensagens(
                        usuarioLogado: _usuarioLogado,
                      ),
                    )
                  ],
                )),
          ],
        ),
      ),
    );
  }
}

class AreaLateralConversas extends StatelessWidget {
  final Usuario usuarioLogado;

  AreaLateralConversas({
    super.key,
    required this.usuarioLogado,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: PaletaCores.corFundoBarraLight,
        border: Border(
            right: BorderSide(
          color: PaletaCores.corFundo,
          width: 1,
        )),
      ),
      child: Column(
        children: [
          //Barra Superior
          Container(
            color: PaletaCores.corFundoBarra,
            padding: EdgeInsets.all(8),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.grey,
                  backgroundImage: CachedNetworkImageProvider(
                    usuarioLogado.urlImagem,
                  ),
                ),
                Spacer(),
                IconButton(onPressed: () {}, icon: Icon(Icons.message)),
                IconButton(
                    onPressed: () async {
                      await FirebaseAuth.instance.signOut().then((value) =>
                          Navigator.pushReplacementNamed(context, "/login"));
                    },
                    icon: Icon(Icons.logout))
              ],
            ),
          ),
          // Barra de Pesquisa
          Container(
            margin: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(100),
            ),
            child: Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.search),
                ),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration.collapsed(
                      hintText: 'Pesquisar uma conversa',
                    ),
                  ),
                ),
              ],
            ),
          ),
          //Lista de conversas
          Expanded(
              child: Container(
            color: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: ListaConversas(),
          )),
        ],
      ),
    );
  }
}

class AreaLateralMensagens extends StatelessWidget {
  final Usuario usuarioLogado;

  const AreaLateralMensagens({super.key, required this.usuarioLogado});

  @override
  Widget build(BuildContext context) {
    final largura = MediaQuery.of(context).size.width;
    final altura = MediaQuery.of(context).size.height;
    Usuario? usuarioDestinatario =
        context.watch<ConversaProvider>().usuarioDestinatario;

    return usuarioDestinatario != null
        ? Column(
            children: [
              //Barra superior
              Container(
                color: PaletaCores.corFundoBarra,
                padding: EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.grey,
                      backgroundImage: CachedNetworkImageProvider(
                        usuarioDestinatario.urlImagem,
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      usuarioDestinatario.nome,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Spacer(),
                    IconButton(onPressed: () {}, icon: Icon(Icons.search)),
                    IconButton(onPressed: () {}, icon: Icon(Icons.more_vert)),
                  ],
                ),
              ),
              //Listagem de mensagens
              Expanded(
                child: ListaMensagens(
                  usuarioRemetente: usuarioLogado,
                  usuarioDestinatario: usuarioDestinatario,
                ),
              ),
            ],
          )
        : Container(
            width: largura,
            height: altura,
            color: PaletaCores.corFundoBarraLight,
            child: Center(
              child: Text(
                "Nenhum contato selecionado!",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
  }
}
