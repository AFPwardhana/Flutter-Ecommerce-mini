import 'package:flutter/material.dart';
import 'package:fourth_project/provider/order.dart' show Orders;
import 'package:fourth_project/widget/app_drawer.dart';
import 'package:fourth_project/widget/order_item.dart';
import 'package:provider/provider.dart';

class OrdersScreen extends StatelessWidget {
  static const routeName = '/orders';
  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Orders'),
      ),
      drawer: AppDrawer(),
      body: ListView.builder(
        itemCount: orderData.orders.length,
        itemBuilder: (ctx, index) => OrderItem(
          orderData.orders[index],
        ),
      ),
    );
  }
}
