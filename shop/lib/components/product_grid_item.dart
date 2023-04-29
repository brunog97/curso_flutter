import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/cart.dart';
import '../models/product.dart';
import '../utils/app_routes.dart';

class ProductGridItem extends StatelessWidget {
  //final Product product;

  const ProductGridItem({
    Key? key,
    //required this.product,
  });

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(
      context,
      listen: false, // as mudanças não refletem a product
    );

    final cart = Provider.of<Cart>(
      context,
      listen: true, // as mudanças  refletem a product
    );

    //ClipRRect cortar de forma arredondada um elemento
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        footer: GridTileBar(
          backgroundColor: Colors.black54,
          //leading: esquerda
          leading: Consumer<Product>(
            //Consumer envolvendo apenas onde há mudança de status
            builder: (ctx, product, _) => IconButton(
              onPressed: () {
                product.toggleFavorite();
              },
              icon: Icon(
                product.isFavorite == true
                    ? Icons.favorite
                    : Icons.favorite_border,
                //Icons.favorite,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
          ),
          //title: meio
          title: Text(
            product.name,
            textAlign: TextAlign.center,
          ),
          //trailing: meio
          trailing: IconButton(
            onPressed: () {
              cart.addItem(product);
              //Esconde o snackbar em exibiçao
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              //limpa todos snackbar caso exista
              //ScaffoldMessenger.of(context).clearSnackBars();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: Colors.blueGrey,
                  content:
                      Text('Produto "${product.name}" adicionado ao carrinho!'),
                  duration: Duration(seconds: 3),
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  action: SnackBarAction(
                    label: 'DESFAZER',
                    onPressed: () {
                      cart.removeSingleItem(product.id);
                    },
                  ),
                ),
              );
            },
            icon: Icon(
              Icons.shopping_cart,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
        ),
        child: GestureDetector(
          onTap: () => Navigator.of(context)
              .pushNamed(AppRoutes.productDetail, arguments: product),
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
