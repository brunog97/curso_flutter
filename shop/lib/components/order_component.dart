import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shop/models/cart_item.dart';
import 'package:shop/models/order.dart';

class OrderComponent extends StatefulWidget {
  final Order order;
  const OrderComponent({super.key, required this.order});

  @override
  State<OrderComponent> createState() => _OrderComponentState();
}

class _OrderComponentState extends State<OrderComponent> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          ListTile(
            title: Text('R\$ ${widget.order.total.toStringAsFixed(2)}'),
            subtitle: Text(
              DateFormat('dd/MM/yyyy hh:mm').format(widget.order.date),
            ),
            trailing: IconButton(
              onPressed: () {
                setState(() {
                  _expanded = !_expanded;
                  print(_expanded);
                });
              },
              icon: Icon(Icons.expand_more),
            ),
          ),
          if (_expanded)
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 4,
              ),
              height: widget.order.products.length * 30.0,
              child: ListView(
                children: widget.order.products.asMap().entries.map((products) {
                  CartItem product = products.value;
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${products.key + 1} - ${product.name}',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                          '${product.quantity}x R\$ ${product.price.toStringAsFixed(2)}',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey,
                          ))
                    ],
                  );
                }).toList(),
              ),
            ),
        ],
      ),
    );
  }
}
