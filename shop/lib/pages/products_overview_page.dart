import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/components/app_drawer.dart';
import 'package:shop/components/sticker.dart';
// import 'package:provider/provider.dart';
// import 'package:shop/models/product_list.dart';
import '../components/product_grid.dart';
import '../models/cart.dart';
import '../utils/app_routes.dart';

enum FilterOptions { favorite, all }

class ProductsOverviewPage extends StatefulWidget {
  ProductsOverviewPage({super.key});

  @override
  State<ProductsOverviewPage> createState() => _ProductsOverviewPageState();
}

class _ProductsOverviewPageState extends State<ProductsOverviewPage> {
  bool _showFavoriteOnly = false;

  @override
  Widget build(BuildContext context) {
    // MEU PROVIDER TA AQUI
    //final provider = Provider.of<ProductList>(context);

    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text("Minha Loja"),
        ),
        actions: [
          PopupMenuButton(
            tooltip: null, //'Opções', // removendo o "show menu"
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
              setState(() {
                if (selectedValue == FilterOptions.favorite) {
                  _showFavoriteOnly = true;
                } else {
                  _showFavoriteOnly = false;
                }
              });
              /*
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
              */
            },
          ),
          Consumer<Cart>(
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(AppRoutes.cart);
              },
              icon: Icon(Icons.shopping_cart),
            ),
            builder: (ctx, cart, child) => Sticker(
              value: cart.itemsCount.toString(),
              child: child!,
            ),
          ),
        ],
      ),
      body: ProductGrid(
        showFavoriteOnly: _showFavoriteOnly,
      ),
      drawer: AppDrawer(),
    );
  }
}
