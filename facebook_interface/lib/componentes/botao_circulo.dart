import 'package:flutter/material.dart';

class BotaoCirculo extends StatelessWidget {
  final IconData icone;
  final double iconeTamanho;
  final VoidCallback onPressed;

  const BotaoCirculo({
    super.key,
    required this.icone,
    required this.iconeTamanho,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    //Borda arrendodada em volta do icone
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        shape: BoxShape.circle,
      ),
      margin: EdgeInsets.all(6),
      child: IconButton(
        icon: Icon(
          icone,
        ),
        iconSize: iconeTamanho,
        color: Colors.black,
        onPressed: onPressed,
      ),
    );
  }
}
