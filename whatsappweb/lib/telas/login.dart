import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:whatsappweb/util/paleta_cores.dart';

import '../model/usuario.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _controllerNome =
      TextEditingController(text: 'Jhon Doe');
  TextEditingController _controllerEmail =
      TextEditingController(text: 'jhondoe@acme.com');
  TextEditingController _controllerSenha =
      TextEditingController(text: 'password');
  bool _cadastroUsuario = false;

  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseStorage _storage = FirebaseStorage.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Uint8List? _arquivoImagemSelecionado;
  String? _extensaoImagemSelecionado;

/* Em uma determinada aula é solicitado que comente o bloco  */
/*
  _verificaUsuarioLogado() {
    User? usuarioLogado = _auth.currentUser;

    if (usuarioLogado != null) {
      Future.delayed(Duration.zero, () async {
        Navigator.pushReplacementNamed(context, "/home");
      });
      // SchedulerBinding.instance.addPostFrameCallback((_) {
      //   Navigator.pushReplacementNamed(context, "/home");
      // });
    }
  }
*/
  _selecionarImagem() async {
    //Selecionar o arquivo
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );

    //Recuperar o arquivo selecionado
    _extensaoImagemSelecionado = result?.files.single.extension;
    setState(() {
      _arquivoImagemSelecionado = result?.files.single.bytes;
    });
  }

  _uploadImagem(Usuario usuario) {
    Uint8List? arquivoSelecionado = _arquivoImagemSelecionado;

    if (arquivoSelecionado != null) {
      // pasta imagens/perfil
      Reference imagemPerfilRef = _storage.ref(
          "imagens/perfil/${usuario.idUsuario}.$_extensaoImagemSelecionado");
      // criando a task de upload do arquivo
      UploadTask uploadTask = imagemPerfilRef.putData(arquivoSelecionado);

      uploadTask.whenComplete(() async {
        String linkImagem = await uploadTask.snapshot.ref
            .getDownloadURL(); //recuperando a URL da foto enviada

        usuario.urlImagem = linkImagem;

        // Atualiza url e nome nos dados do currentUser do firebase
        await _auth.currentUser?.updateDisplayName(usuario.nome);
        await _auth.currentUser?.updatePhotoURL(usuario.urlImagem);

        //print("link da imagem $linkImagem");

        final usuariosRef = _firestore.collection("usuarios");

        usuariosRef.doc(usuario.idUsuario).set(usuario.toMap()).then((value) {
          // tela principal da app
          Navigator.pushReplacementNamed(context, "/home");
        });
      });
    }
  }

  // função pra validar os campos, efetuar cadastro e login
  _validarCampos() async {
    String nome = _controllerNome.text;
    String email = _controllerEmail.text;
    String senha = _controllerSenha.text;

    if (email.isNotEmpty && email.contains('@')) {
      if (senha.isNotEmpty && senha.length > 6) {
        if (_cadastroUsuario) {
          if (nome.isNotEmpty && nome.length >= 5) {
            await _auth
                .createUserWithEmailAndPassword(email: email, password: senha)
                .then((auth) {
              // Upload da imagem
              String? idUsuario = auth.user?.uid;

              if (idUsuario != null) {
                Usuario usuario = Usuario(idUsuario, nome, email);
                _uploadImagem(usuario);
              }

              //print(idUsuario);
            });
          }
        } else {
          //login
          await _auth
              .signInWithEmailAndPassword(email: email, password: senha)
              .then((auth) {
            // tela principal da app
            Navigator.pushReplacementNamed(context, "/home");
          });
        }
      } else {}
    } else {}
  }

  // Antes de carregar o widget eu verifico se existe um usuario logado
  @override
  void initState() {
    super.initState();
    //_verificaUsuarioLogado();
  }

  @override
  Widget build(BuildContext context) {
    double alturaTela = MediaQuery.of(context).size.height;
    double larguraTela = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        color: PaletaCores.corFundo,
        width: larguraTela,
        height: alturaTela,
        child: Stack(
          children: [
            Positioned(
              child: Container(
                width: larguraTela,
                height: alturaTela * 0.5, //50% da tela
                color: PaletaCores.corPrimaria,
              ),
            ),
            Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Container(
                      padding: EdgeInsets.all(40),
                      width: 500,
                      child: Column(
                        children: [
                          Visibility(
                            visible: _cadastroUsuario,
                            child: ClipOval(
                              child: _arquivoImagemSelecionado != null
                                  ? Image.memory(
                                      _arquivoImagemSelecionado!,
                                      width: 120,
                                      height: 120,
                                      fit: BoxFit.cover,
                                    )
                                  : Image.asset(
                                      "imagens/perfil.png",
                                      width: 120,
                                      height: 120,
                                      fit: BoxFit.cover,
                                    ),
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Visibility(
                            visible: _cadastroUsuario,
                            child: OutlinedButton(
                              onPressed: _selecionarImagem,
                              child: Text("Selecionar foto"),
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Visibility(
                              visible: _cadastroUsuario,
                              child: TextField(
                                keyboardType: TextInputType.text,
                                controller: _controllerNome,
                                decoration: InputDecoration(
                                    hintText: "Nome",
                                    labelText: "Nome",
                                    suffixIcon: Icon(Icons.person_outline)),
                              )),
                          TextField(
                            keyboardType: TextInputType.emailAddress,
                            controller: _controllerEmail,
                            decoration: InputDecoration(
                                hintText: "Email",
                                labelText: "Email",
                                suffixIcon: Icon(Icons.mail_outline)),
                          ),
                          TextField(
                            keyboardType: TextInputType.text,
                            controller: _controllerSenha,
                            obscureText: true,
                            decoration: InputDecoration(
                                hintText: "Senha",
                                labelText: "Senha",
                                suffixIcon: Icon(Icons.lock_outline)),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                _validarCampos();
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: PaletaCores.corPrimaria,
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 8),
                                child: Text(
                                  _cadastroUsuario ? "Cadastrar" : "Logar",
                                  style: TextStyle(fontSize: 18),
                                ),
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Text("Login"),
                              Switch(
                                  value: _cadastroUsuario,
                                  onChanged: (bool valor) {
                                    setState(() {
                                      _cadastroUsuario = valor;
                                    });
                                  }),
                              Text("Cadastro")
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
