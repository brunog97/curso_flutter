import 'package:cached_network_image/cached_network_image.dart';
import 'package:facebook_interface/componentes/imagem_perfil.dart';
import 'package:facebook_interface/dados/dados.dart';
import 'package:facebook_interface/uteis/responsivo.dart';
import 'package:facebook_interface/uteis/scroll_behavior.dart';
import 'package:flutter/material.dart';
import '../modelos/modelos.dart';
import '../uteis/paleta_cores.dart';

class AreaStorie extends StatelessWidget {
  final Usuario usuario;
  final List<Estoria> estorias;

  const AreaStorie({
    super.key,
    required this.usuario,
    required this.estorias,
  });

  @override
  Widget build(BuildContext context) {
    bool isDesktop = Responsivo.isDesktop(context);
    return Container(
      height: 200,
      color: isDesktop ? Colors.transparent : Colors.white,
      child: ScrollConfiguration(
        behavior: MyScrollBehavior(),
        child: ListView.builder(
          padding: EdgeInsets.symmetric(
            horizontal: 8,
            vertical: 10,
          ),
          scrollDirection: Axis.horizontal,
          itemCount: 1 + estorias.length,
          itemBuilder: (context, index) {
            if (index == 0) {
              Estoria estoriaUsuario = Estoria(
                  usuario: usuarioAtual, urlImagem: usuarioAtual.urlImagem);

              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 4),
                child: CartaoStorie(
                  adicionarEstoria: true,
                  estoria: estoriaUsuario,
                ),
              );
            }

            Estoria estoria = estorias[index - 1];
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 4),
              child: CartaoStorie(
                estoria: estoria,
              ),
            );
          },
        ),
      ),
    );
  }
}

class CartaoStorie extends StatelessWidget {
  final Estoria estoria;
  final bool adicionarEstoria;

  const CartaoStorie({
    super.key,
    required this.estoria,
    this.adicionarEstoria = false,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        //ClipRRect: Arredondar imagem
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: CachedNetworkImage(
            height: double.infinity,
            width: 110,
            fit: BoxFit.cover,
            imageUrl: estoria.urlImagem,
          ),
        ),
        Container(
          height: double.infinity,
          width: 110,
          decoration: BoxDecoration(
            gradient: PaletaCores.degradeEstoria,
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        Positioned(
          top: 8,
          left: 8,
          child: adicionarEstoria
              ? Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {},
                    icon: Icon(Icons.add),
                    iconSize: 30,
                    color: PaletaCores.azulFacebook,
                  ),
                )
              : ImagemPerfil(
                  urlImagem: estoria.usuario.urlImagem,
                  foiVisualizado: estoria.foiVisualizado,
                ),
        ),
        Positioned(
          bottom: 8,
          left: 8,
          right: 8,
          child: Text(
            adicionarEstoria ? "Crie o seu storie" : estoria.usuario.nome,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        )
      ],
    );
  }
}
