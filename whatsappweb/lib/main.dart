import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:whatsappweb/Provider/conversa_provider.dart';
import 'package:whatsappweb/firebase_options.dart';
import 'package:whatsappweb/rotas.dart';
import 'package:provider/provider.dart';

final ThemeData temaPadrao = ThemeData(
  primarySwatch: Colors.green,
);

void main() async {
  setPathUrlStrategy(); //remover /#/
  WidgetsFlutterBinding
      .ensureInitialized(); // não sei pra que server mas acho que tem haver como o firebase
  //Inicalização do firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  //Verifica se possui algum usuario logado
  User? usuarioLogado = FirebaseAuth.instance.currentUser;
  String urlInicial = "/";

  if (usuarioLogado != null) {
    urlInicial = "/home";
  }

  runApp(ChangeNotifierProvider(
    create: (context) => ConversaProvider(),
    child: MaterialApp(
      title: "WhatsApp Web",
      debugShowCheckedModeBanner: false,
      //home: Login(),
      theme: temaPadrao,
      initialRoute: urlInicial,
      onGenerateRoute: Rotas.gerarRota,
    ),
  ));
}
