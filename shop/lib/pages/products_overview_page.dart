import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/product_list.dart';
import '../components/product_grid.dart';

enum FilterOptions { favorite, all }

class ProductsOverviewPage extends StatelessWidget {
  ProductsOverviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    // MEU PROVIDER TA AQUI
    final provider = Provider.of<ProductList>(context);

    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text("Minha Loja"),
        ),
        actions: [
          PopupMenuButton(
            tooltip: 'Exibir Opções', // removendo o "show menu"
            itemBuilder: (_) => [
              PopupMenuItem(
                value: FilterOptions.favorite,
                child: Text('Somente Favoritos'),
              ),
              PopupMenuItem(
                value: FilterOptions.all,
                child: Text('Todos'),
              ),
            ],
            //onSelected trabalha em conjunto com o actions - ele devolve o que foi selecionado
            onSelected: (FilterOptions selectedValue) {
              switch (selectedValue) {
                case FilterOptions.favorite:
                  provider.showFavoriteOnly();
                  break;
                case FilterOptions.all:
                  provider.showAll();
                  break;
                default:
                  break;
              }
            },
          ),
        ],
      ),
      body: ProductGrid(),
    );
  }
}
