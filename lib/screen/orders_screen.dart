import 'package:flutter/material.dart';
import 'package:fourth_project/provider/order.dart' show Orders;
import 'package:fourth_project/widget/app_drawer.dart';
import 'package:fourth_project/widget/order_item.dart';
import 'package:provider/provider.dart';

class OrdersScreen extends StatefulWidget {
  static const routeName = '/orders';

  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  // var _isLoading = false;

  // @override
  // void initState() {
  //   setState(() {
  //     _isLoading = true;
  //   });
  //   Provider.of<Orders>(context, listen: false).fetchOrders().then((value) {
  //     setState(() {
  //       _isLoading = false;
  //     });
  //   });
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    // final orderData = Provider.of<Orders>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text('Your Orders'),
        ),
        drawer: AppDrawer(),
        body: FutureBuilder(
          future: Provider.of<Orders>(context, listen: false).fetchOrders(),
          builder: (ctx, dataSnapshot) {
            if (dataSnapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              if (dataSnapshot.error != null) {
                return Center(
                  child: Text('An error occured'),
                );
              } else {
                return Consumer<Orders>(
                  builder: (context, value, child) => ListView.builder(
                    itemCount: value.orders.length,
                    itemBuilder: (ctx, index) => OrderItem(
                      value.orders[index],
                    ),
                  ),
                );
              }
            }
          },
        )

        // _isLoading
        //     ? Center(
        //         child: CircularProgressIndicator(),
        //       )
        //     : ListView.builder(
        //         itemCount: orderData.orders.length,
        //         itemBuilder: (ctx, index) => OrderItem(
        //           orderData.orders[index],
        //         ),
        //       ),
        );
  }
}
