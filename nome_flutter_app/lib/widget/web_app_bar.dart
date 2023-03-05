import 'package:flutter/material.dart';

class WebAppBar extends StatelessWidget {
  const WebAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
        title: Row(
      children: [
        Image.asset(
          "asset/images/logo.png",
          fit: BoxFit.contain,
        ),
        Expanded(
          child: SizedBox(),
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.search),
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.shopping_cart_rounded),
        ),
        OutlinedButton(
          onPressed: () {},
          style: OutlinedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.lightBlueAccent,
          ),
          child: Text('Cadastrar'),
        ),
        SizedBox(
          width: 10,
        ),
        OutlinedButton(
          onPressed: () {},
          style: OutlinedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.orange,
          ),
          child: Text('Entrar'),
        )
      ],
    ));
  }
}
