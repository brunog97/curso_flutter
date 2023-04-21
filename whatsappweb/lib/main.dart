import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
//import 'package:url_strategy/url_strategy.dart';
import 'package:whatsappweb/Provider/conversa_provider.dart';
import 'package:whatsappweb/firebase_options.dart';
import 'package:provider/provider.dart';
import 'package:whatsappweb/rotas.dart';
import 'package:whatsappweb/telas/home.dart';
import 'package:whatsappweb/telas/login.dart';
import 'package:whatsappweb/telas/mensagens.dart';

final ThemeData temaPadrao = ThemeData(
  primarySwatch: Colors.green,
);

void main() async {
  //setPathUrlStrategy(); //remover /#/
  setUrlStrategy(PathUrlStrategy());
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
      routes: {
        "/": (ctx) => Login(),
        "/login": (ctx) => Login(),
        "/home": (ctx) => Home(),
      },
      onGenerateRoute: Rotas.gerarRota,
    ),
  ));
}
