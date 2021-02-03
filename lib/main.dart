import 'package:flutter/material.dart';
import 'package:fourth_project/provider/auth.dart';
import 'package:fourth_project/provider/cart.dart';
import 'package:fourth_project/provider/order.dart';
import 'package:fourth_project/provider/products_provider.dart';
import 'package:fourth_project/screen/auth_screen.dart';
import 'package:fourth_project/screen/cart_screen.dart';
import 'package:fourth_project/screen/edit_product_screen.dart';
import 'package:fourth_project/screen/orders_screen.dart';
import 'package:fourth_project/screen/product_detail.dart';
import 'package:fourth_project/screen/product_overview.dart';
import 'package:fourth_project/screen/splash_screen.dart';
import 'package:fourth_project/screen/user_products.dart';
import 'package:provider/provider.dart';

// folder 10 ep 10

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, ProductsProvider>(
          create: null,
          update: (context, value, previous) => ProductsProvider(
            value.getToken,
            value.getUserId,
            previous == null ? [] : previous.items,
          ),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Cart(),
        ),
        ChangeNotifierProxyProvider<Auth, Orders>(
          create: null,
          update: (context, value, previous) => Orders(
            value.getToken,
            value.getUserId,
            previous == null ? [] : previous.orders,
          ),
        ),
      ],
      child: Consumer<Auth>(
        builder: (context, value, child) => MaterialApp(
          title: 'MyShop',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            accentColor: Colors.orangeAccent[700],
            fontFamily: 'Lato',
          ),
          home: value.isAuth
              ? ProduckOverviewScreen()
              : FutureBuilder(
                  future: value.tryAutoLogin(),
                  builder: (context, snapshot) =>
                      snapshot.connectionState == ConnectionState.waiting
                          ? SplashScreen()
                          : AuthScreen(),
                ),
          routes: {
            CartScreen.routeName: (ctx) => CartScreen(),
            ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
            OrdersScreen.routeName: (ctx) => OrdersScreen(),
            UserProductScreen.routeName: (_) => UserProductScreen(),
            EditProductsScreen.routeName: (_) => EditProductsScreen(),
          },
        ),
      ),
    );
  }
}
