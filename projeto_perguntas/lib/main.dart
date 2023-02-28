// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:projeto_perguntas/questionario.dart';
import 'package:projeto_perguntas/resultado.dart';

main() => runApp(const PerguntaApp());

class _PerguntaAppState extends State<PerguntaApp> {
  var _perguntaSelecionada = 0;
  var _pontuacaoTotal = 0;

  void _responder(int pontuacao) {
    if (temPerguntaSelecionada) {
      setState(() {
        _perguntaSelecionada++;
        _pontuacaoTotal += pontuacao;
      });
    }
  }

  void _reiniciarForm() {
    setState(() {
      _perguntaSelecionada = 0;
      _pontuacaoTotal = 0;
    });
  }

  final List<Map<String, Object>> _perguntas = const [
    {
      'texto': 'Qual é sua cor favorita?',
      'respostas': [
        {'texto': 'Verde', 'pontuacao': 1},
        {'texto': 'Amarelo', 'pontuacao': 1},
        {'texto': 'Azul', 'pontuacao': 3},
        {'texto': 'Branco', 'pontuacao': 8},
      ],
    },
    {
      'texto': 'Qual é seu animal favorito?',
      'respostas': [
        {'texto': 'Gato', 'pontuacao': 10},
        {'texto': 'Cachorro', 'pontuacao': 5},
        {'texto': 'Cobra', 'pontuacao': 1},
        {'texto': 'Arara', 'pontuacao': 10},
      ],
    },
    {
      'texto': 'Qual é sua stack favorita?',
      'respostas': [
        {'texto': 'JS', 'pontuacao': 8},
        {'texto': 'Flutter', 'pontuacao': 7},
        {'texto': 'Angular', 'pontuacao': 3},
        {'texto': '.Net', 'pontuacao': 5},
      ],
    }
  ];

  bool get temPerguntaSelecionada {
    return _perguntaSelecionada < _perguntas.length;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Perguntas'),
        ),
        body: temPerguntaSelecionada
            ? Questionario(
                perguntas: _perguntas,
                perguntaSelecionada: _perguntaSelecionada,
                responder: _responder,
              )
            : Resultado(
                _pontuacaoTotal,
                _reiniciarForm,
              ),
      ),
    );
  }
}

class PerguntaApp extends StatefulWidget {
  const PerguntaApp({super.key});

  @override
  State<PerguntaApp> createState() {
    return _PerguntaAppState();
  }
}
