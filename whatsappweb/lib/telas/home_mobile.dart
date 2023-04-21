import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:whatsappweb/componentes/lista_contatos.dart';
import 'package:whatsappweb/componentes/lista_conversas.dart';

class HomeMobile extends StatefulWidget {
  const HomeMobile({super.key});

  @override
  State<HomeMobile> createState() => _HomeMobileState();
}

class _HomeMobileState extends State<HomeMobile> {
  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            leading: null,
            automaticallyImplyLeading: false,
            title: Text("WhatsApp"),
            actions: [
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.search),
              ),
              SizedBox(
                width: 3,
              ),
              IconButton(
                onPressed: () async {
                  await _auth.signOut().whenComplete(
                      () => Navigator.pushNamed(context, "/login"));
                  //Navigator.pushReplacementNamed(context, "/login"));
                },
                icon: Icon(Icons.logout),
              )
            ],
            bottom: TabBar(
                indicatorColor: Colors.white,
                indicatorWeight: 4,
                labelStyle: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                tabs: [
                  // Lista de conversas
                  Tab(
                    text: 'Conversas',
                  ),
                  //Lista de contatos
                  Tab(
                    text: 'Contatos',
                  )
                ]),
          ),
          body: SafeArea(
              child: TabBarView(children: [
            // Conversas
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 8,
              ),
              child: ListaConversas(),
            ),
            // Lista de contatos
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 8,
              ),
              child: ListaContatos(),
            )
          ])),
        ));
  }
}
