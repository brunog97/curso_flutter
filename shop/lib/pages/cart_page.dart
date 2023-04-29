import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/components/cart_item.dart';
import 'package:shop/models/cart_item.dart';
import 'package:shop/models/order_list.dart';

import '../models/cart.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Cart cart = Provider.of(context);
    final items = cart.items.values.toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Carrinho'),
      ),
      body: items.isEmpty
          ? Center(
              child: Text('Ah não! Seu carrinho esta vazio :('),
            )
          : Column(
              children: [
                Card(
                  margin: EdgeInsets.all(25),
                  //color: Colors.red,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total',
                          style: TextStyle(fontSize: 20),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Chip(
                          backgroundColor:
                              Theme.of(context).colorScheme.primary,
                          label: Text(
                            'R\$ ${cart.totalAmount.toStringAsFixed(2)}',
                            style: TextStyle(
                              color: Theme.of(context)
                                  .primaryTextTheme
                                  .titleLarge
                                  ?.color,
                            ),
                          ),
                        ),
                        Spacer(),
                        CartButton(items: items, cart: cart),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (context, index) =>
                        CartItemW(cartItem: items[index]),
                  ),
                ),
              ],
            ),
    );
  }
}

class CartButton extends StatefulWidget {
  const CartButton({
    super.key,
    required this.items,
    required this.cart,
  });

  final List<CartItem> items;
  final Cart cart;

  @override
  State<CartButton> createState() => _CartButtonState();
}

class _CartButtonState extends State<CartButton> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? CircularProgressIndicator()
        : TextButton(
            onPressed: widget.items.isEmpty
                ? null
                : () async {
                    setState(() => _isLoading = true);
                    // Limpando a lista de snackbars
                    ScaffoldMessenger.of(context).clearSnackBars();

                    /*
                      Inicialmente eu fiz a chamada do processo apenas quando o carrinho tivesse itens.
                      */
                    //if (cart.itemsCount > 0) {
                    await Provider.of<OrderList>(context, listen: false)
                        .addOrder(widget.cart);

                    setState(() => _isLoading = false);
                    widget.cart.clear();
                    //}
                  },
            style: TextButton.styleFrom(
                textStyle: TextStyle(
              color: Theme.of(context).colorScheme.primary,
            )),
            child: Text('COMPRAR'),
          );
  }
}
