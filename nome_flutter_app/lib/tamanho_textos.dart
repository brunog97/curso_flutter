import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class TamanhoTextos extends StatefulWidget {
  const TamanhoTextos({super.key});

  @override
  State<TamanhoTextos> createState() => _TamanhoTextosState();
}

class _TamanhoTextosState extends State<TamanhoTextos> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Tamanhos de textos'),
        ),
        body: Column(
          children: [
            Text(
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed sed ex in lacus rhoncus dictum. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae; Curabitur vel augue gravida eros aliquam hendrerit. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Vestibulum non porttitor dolor, quis tristique tellus. Etiam porttitor nunc ut venenatis lobortis. Pellentesque sodales venenatis diam ut vestibulum. Suspendisse feugiat facilisis est, fermentum suscipit dui faucibus a. Sed rhoncus dapibus nisl ac imperdiet. Maecenas aliquet est lorem, ac condimentum magna lacinia vel.",
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            SizedBox(
              height: 50,
            ),
            AutoSizeText(
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed sed ex in lacus rhoncus dictum. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae; Curabitur vel augue gravida eros aliquam hendrerit. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Vestibulum non porttitor dolor, quis tristique tellus. Etiam porttitor nunc ut venenatis lobortis. Pellentesque sodales venenatis diam ut vestibulum. Suspendisse feugiat facilisis est, fermentum suscipit dui faucibus a. Sed rhoncus dapibus nisl ac imperdiet. Maecenas aliquet est lorem, ac condimentum magna lacinia vel.",
              style: TextStyle(
                fontSize: 30,
              ),
              /*
              maxLines: 2,
              minFontSize: 14,
              //overflow: TextOverflow.ellipsis,
              overflowReplacement: Text('Não coube!'),
              */
              /*
              minFontSize: 10,
              maxLines: 2,
              stepGranularity: 10, //A fonte vai caindo de size de 10 em 10
              */

              maxLines: 3,
              presetFontSizes: [
                30,
                22,
                10,
              ], //Fontes a cair...
            ),
          ],
        ));
  }
}
