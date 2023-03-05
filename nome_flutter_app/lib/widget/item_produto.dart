import 'package:flutter/material.dart';

class ItemProduto extends StatelessWidget {
  final String descricao;
  final String preco;
  final String imagem;

  ItemProduto(
    this.descricao,
    this.preco,
    this.imagem,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.black,
        ),
      ),
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          Expanded(
            flex: 8,
            child: Image.asset(
              "asset/images/$imagem",
              fit: BoxFit.contain,
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(descricao),
          ),
          Expanded(
            flex: 1,
            child: Text(
              "R\$ $preco",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
