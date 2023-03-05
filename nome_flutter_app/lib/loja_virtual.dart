import 'package:flutter/material.dart';
import 'package:responsividade_app/widget/item_produto.dart';
import 'package:responsividade_app/widget/mobile_app_bar.dart';
import 'package:responsividade_app/widget/web_app_bar.dart';

class LojaVirtual extends StatefulWidget {
  const LojaVirtual({super.key});

  @override
  State<LojaVirtual> createState() => _LojaVirtualState();
}

class _LojaVirtualState extends State<LojaVirtual> {
  int _ajustarVisualizacao(double largura) {
    int colunas = 2;

    if (largura <= 600) {
      colunas = 2;
    } else if (largura <= 960) {
      colunas = 4;
    } else {
      colunas = 6;
    }

    return colunas;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraint) {
      var largura = constraint.maxWidth; //largura maxima da tela
      var alturaBarra = AppBar().preferredSize.height;

      return Scaffold(
        backgroundColor: Colors.blueGrey,
        appBar: largura < 600
            ? PreferredSize(
                preferredSize: Size(largura, alturaBarra),
                child: MobileAppBar(),
              )
            : PreferredSize(
                preferredSize: Size(largura, alturaBarra),
                child: WebAppBar(),
              ),
        body: Padding(
          padding: EdgeInsets.all(16),
          child: GridView.count(
            crossAxisCount: _ajustarVisualizacao(largura),
            crossAxisSpacing: 8, //Espaçamento vertical
            mainAxisSpacing: 8, //Espaçamento horizontal
            children: [
              ItemProduto("Kit MUltimidia", "2.200,00", "p1.jpg"),
              ItemProduto("Pneu GoodYear 16\"", "150,00", "p2.jpg"),
              ItemProduto("Samsung S9", "4.100,00", "p3.jpg"),
              ItemProduto("Samsung edge", "2.1500,90", "p4.jpg"),
              ItemProduto("Galaxy S10", "6.200,00", "p5.jpg"),
              ItemProduto("iPhone 10", "1.900,20", "p6.jpg"),
              ItemProduto("Kit MUltimidia", "2.200,00", "p1.jpg"),
              ItemProduto("Pneu GoodYear 16\"", "150,00", "p2.jpg"),
              ItemProduto("Samsung S9", "4.100,00", "p3.jpg"),
              ItemProduto("Samsung edge", "2.1500,90", "p4.jpg"),
              ItemProduto("Galaxy S10", "6.200,00", "p5.jpg"),
              ItemProduto("iPhone 10", "1.900,20", "p6.jpg"),
              ItemProduto("Kit MUltimidia", "2.200,00", "p1.jpg"),
              ItemProduto("Pneu GoodYear 16\"", "150,00", "p2.jpg"),
              ItemProduto("Samsung S9", "4.100,00", "p3.jpg"),
              ItemProduto("Samsung edge", "2.1500,90", "p4.jpg"),
              ItemProduto("Galaxy S10", "6.200,00", "p5.jpg"),
              ItemProduto("iPhone 10", "1.900,20", "p6.jpg"),
            ],
          ),
        ),
      );
    });
  }
}
