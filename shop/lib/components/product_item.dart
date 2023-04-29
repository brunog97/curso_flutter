import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/product.dart';
import 'package:shop/models/product_list.dart';
import 'package:shop/utils/app_routes.dart';

class ProductItem extends StatelessWidget {
  final Product product;
  const ProductItem({required this.product});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(product.imageUrl),
      ),
      title: Text(product.name),
      trailing: SizedBox(
        width: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () => Navigator.of(context)
                  .pushNamed(AppRoutes.productform, arguments: product),
              icon: Icon(
                Icons.edit,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            IconButton(
              onPressed: () {
                showDialog<bool>(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('Excluir Produto'),
                    content: Text('Confirma a exclusão do produto?'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(false),
                        child: Text('Não'),
                      ),
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(true),
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(Colors.purple),
                        ),
                        child: Text(
                          'Sim',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ).then((resposta) => resposta ?? false
                    ? Provider.of<ProductList>(context, listen: false)
                        .removeProduct(product)
                    : null);
              },
              icon: Icon(
                Icons.delete,
                color: Theme.of(context).colorScheme.error,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
