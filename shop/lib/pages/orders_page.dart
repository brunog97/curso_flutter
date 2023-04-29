import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/components/app_drawer.dart';
import 'package:shop/components/order_component.dart';

import '../models/order_list.dart';

class OrdersPage extends StatelessWidget {
  // bool _isLoading = true;

  // @override
  // void initState() {
  //   super.initState();
  //   Provider.of<OrderList>(context, listen: false).loadOrders().then(
  //         (_) => setState(() => _isLoading = false),
  //       );
  // }

  @override
  Widget build(BuildContext context) {
    //final OrderList orders = Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Meus Pedidos'),
      ),
      drawer: AppDrawer(),
      body: FutureBuilder(
        future: Provider.of<OrderList>(context, listen: false).loadOrders(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Consumer<OrderList>(
              builder: (context, orders, _) => orders.itemsCount == 0
                  ? Center(
                      child: Text('Não há pedidos'),
                    )
                  : ListView.builder(
                      itemCount: orders.itemsCount,
                      itemBuilder: (ctx, i) => OrderComponent(
                        order: orders.items[i],
                      ),
                    ),
            );
          }
        },
      ),
      /*
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : orders.itemsCount == 0
              ? Center(
                  child: Text('Não há pedidos'),
                )
              : ListView.builder(
                  itemCount: orders.itemsCount,
                  itemBuilder: (ctx, i) =>
                      OrderComponent(order: orders.items[i]),
                ),
    */
    );
  }
}
