import 'package:flutter/material.dart';
import 'package:pomodoro/page/pomodoro_page.dart';
import 'package:pomodoro/store/pomodoro.store.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<PomodoroStore>(
          create: (_) => PomodoroStore(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        home: const Pomodoro(),
      ),
    );
  }
}


/*
// REFERENCIA SOBRE  STORE MOBX

import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:pomodoro/store/contador.store.dart';


final storeContador = ContadorStore();

class HomeApp extends StatelessWidget {
  const HomeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('You have pushed the button this many times:'),
            //Observer faz com que tenha reatividade em cima do contador
            Observer(
              builder: (_) => Text(
                '${storeContador.contador}',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: storeContador.incrementar,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}


*/