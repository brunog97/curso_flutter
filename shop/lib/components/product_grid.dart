import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/components/product_grid_item.dart';
import 'package:shop/models/product_list.dart';
import '../models/product.dart';

class ProductGrid extends StatelessWidget {
  final bool showFavoriteOnly;
  const ProductGrid({super.key, required this.showFavoriteOnly});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductList>(context);
    final List<Product> loadedProducts =
        showFavoriteOnly ? provider.favoriteItems : provider.items;

    return loadedProducts.isEmpty
        ? Center(
            child: Text('Não há nada para exibir aqui'),
          )
        : GridView.builder(
            padding: const EdgeInsets.all(10.0),
            itemCount: loadedProducts.length,
            itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
              value: loadedProducts[i],
              child: ProductGridItem(),
            ),
            //SliverGridDelegateWithFixedCrossAxisCount => Area rolavel "Sliver"
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // 2 produtos por linha
              childAspectRatio: 3 / 2, //não entendi
              crossAxisSpacing: 10, //espaçamento na vertical
              mainAxisSpacing: 10, //espaçamento na horizontal
            ),
          );
  }
}
