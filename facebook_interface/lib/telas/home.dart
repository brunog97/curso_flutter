import 'package:facebook_interface/componentes/area_criar_postagem.dart';
import 'package:facebook_interface/componentes/area_storie.dart';
import 'package:facebook_interface/componentes/botao_circulo.dart';
import 'package:facebook_interface/componentes/cartao_postagem.dart';
import 'package:facebook_interface/componentes/lista_contatos.dart';
import 'package:facebook_interface/componentes/lista_opcoes.dart';
import 'package:facebook_interface/dados/dados.dart';
import 'package:facebook_interface/modelos/modelos.dart';
import 'package:facebook_interface/uteis/paleta_cores.dart';
import 'package:facebook_interface/uteis/responsivo.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TrackingScrollController _scrollController = TrackingScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Responsivo(
          mobile: HomeMobile(
            scrollController: _scrollController,
          ),
          desktop: HomeDesktop(
            scrollController: _scrollController,
          ),
        ),
      ),
    );
  }
}

class HomeMobile extends StatelessWidget {
  final TrackingScrollController scrollController;
  const HomeMobile({
    super.key,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    // widgets pensados para funcionarem "juntos"... sobem e descem juntos
    return CustomScrollView(
      controller: scrollController,
      slivers: <Widget>[
        SliverAppBar(
          backgroundColor: Colors.white,
          //expandedHeight:altura expandida da appbar
          //expandedHeight: 250,
          //floating: quando utilizado a barra "futua" ao scrollar a pagina
          floating: true,
          centerTitle: false,
          actions: [
            BotaoCirculo(
              icone: Icons.search,
              iconeTamanho: 30,
              onPressed: () {},
            ),
            BotaoCirculo(
              icone: LineIcons.facebookMessenger,
              iconeTamanho: 30,
              onPressed: () {},
            )
          ],
          title: Text(
            'facebook',
            style: TextStyle(
              color: PaletaCores.azulFacebook,
              fontWeight: FontWeight.bold,
              fontSize: 28,
              letterSpacing: -1.2,
            ),
          ),
        ),
        SliverToBoxAdapter(
            child: AreaCriarPostagem(
          usuario: usuarioAtual,
        )),
        SliverPadding(
          padding: EdgeInsets.fromLTRB(0, 10, 0, 5),
          sliver: SliverToBoxAdapter(
            child: AreaStorie(
              usuario: usuarioAtual,
              estorias: estorias,
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              Postagem postagem = postagens[index]; //Recuperando as postagens
              return CartaoPostagem(postagem: postagem);
            },
            childCount: postagens.length,
          ),
        ),
      ],
    );
  }
}

class HomeDesktop extends StatelessWidget {
  final TrackingScrollController scrollController;

  const HomeDesktop({
    super.key,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          flex: 2,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: ListaOpcoes(
              usuario: usuarioAtual,
            ),
          ),
        ),
        //Spacer(): Espaçamento entre flexible
        Spacer(),
        Flexible(
            flex: 6,
            child: CustomScrollView(
              controller: scrollController,
              slivers: <Widget>[
                SliverPadding(
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 5),
                  sliver: SliverToBoxAdapter(
                    child: AreaStorie(
                      usuario: usuarioAtual,
                      estorias: estorias,
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                    child: AreaCriarPostagem(
                  usuario: usuarioAtual,
                )),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      Postagem postagem =
                          postagens[index]; //Recuperando as postagens
                      return CartaoPostagem(postagem: postagem);
                    },
                    childCount: postagens.length,
                  ),
                ),
              ],
            )),
        //Spacer(): Espaçamento entre flexible
        Spacer(),
        Flexible(
          flex: 2,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: ListaContatos(
              usuarios: usuariosOnline,
            ),
          ),
        ),
      ],
    );
  }
}
