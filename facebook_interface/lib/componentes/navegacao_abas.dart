import 'package:facebook_interface/uteis/paleta_cores.dart';
import 'package:facebook_interface/uteis/responsivo.dart';
import 'package:flutter/material.dart';

class NavegacaoAbas extends StatelessWidget {
  final List<IconData> icones;
  final int indiceAbaSelecionada;
  final Function(int) onTap;

  const NavegacaoAbas(
      {super.key,
      required this.icones,
      required this.indiceAbaSelecionada,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    final bool isDesktop = Responsivo.isDesktop(context);
    return TabBar(
        onTap: onTap,
        indicator: BoxDecoration(
          border: isDesktop
              ? Border(
                  bottom: BorderSide(color: PaletaCores.azulFacebook, width: 3),
                )
              : Border(
                  top: BorderSide(color: PaletaCores.azulFacebook, width: 3),
                ),
        ),
        tabs: icones
            .asMap() //Convertido a "asMap()" para poder pegar o indice e alterar a cor do icone
            .map((indice, icone) {
              return MapEntry(
                indice,
                Tab(
                  icon: Icon(
                    icone,
                    color: indiceAbaSelecionada == indice
                        ? PaletaCores.azulFacebook
                        : Colors.black,
                    size: 30,
                  ),
                ),
              );
            })
            .values
            .toList() // Efetuar conversão para lista....
        );
  }
}
