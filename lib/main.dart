import 'package:flutter/material.dart';
import 'package:fourth_project/provider/cart.dart';
import 'package:fourth_project/provider/order.dart';
import 'package:fourth_project/provider/products_provider.dart';
import 'package:fourth_project/screen/cart_screen.dart';
import 'package:fourth_project/screen/edit_product_screen.dart';
import 'package:fourth_project/screen/orders_screen.dart';
import 'package:fourth_project/screen/product_detail.dart';
import 'package:fourth_project/screen/product_overview.dart';
import 'package:fourth_project/screen/user_products.dart';
import 'package:provider/provider.dart';

// folder 9 ap 15 done
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => ProductsProvider(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Cart(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Orders(),
        ),
      ],
      child: MaterialApp(
        title: 'MyShop',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          accentColor: Colors.orangeAccent[700],
          fontFamily: 'Lato',
        ),
        home: ProduckOverviewScreen(),
        routes: {
          CartScreen.routeName: (ctx) => CartScreen(),
          ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
          OrdersScreen.routeName: (ctx) => OrdersScreen(),
          UserProductScreen.routeName: (_) => UserProductScreen(),
          EditProductsScreen.routeName: (_) => EditProductsScreen(),
        },
      ),
    );
  }
}
