import 'package:facebook_interface/componentes/botao_imagem_perfil.dart';
import 'package:flutter/material.dart';

import '../modelos/modelos.dart';

class ListaContatos extends StatelessWidget {
  final List<Usuario> usuarios;

  const ListaContatos({super.key, required this.usuarios});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(
        children: [
          Expanded(
            child: Text(
              'Contatos',
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[700]),
            ),
          ),
          IconButton(onPressed: () {}, icon: Icon(Icons.video_call)),
          IconButton(onPressed: () {}, icon: Icon(Icons.search)),
          IconButton(onPressed: () {}, icon: Icon(Icons.more_horiz)),
        ],
      ),
      Expanded(
        child: ListView.builder(
          //Este padding é da lista e não dos items da lista
          //padding: EdgeInsets.symmetric(vertical: 10),
          itemCount: usuarios.length,
          itemBuilder: (context, index) {
            Usuario usuario = usuarios[index];
            return Padding(
              //Padding dos items
              padding: const EdgeInsets.symmetric(vertical: 6.0),
              child: BotaoImagemPerfil(usuario: usuario, onTap: () {}),
            );
          },
        ),
      ),
    ]);
  }
}
