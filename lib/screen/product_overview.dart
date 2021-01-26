import 'package:flutter/material.dart';
import 'package:fourth_project/provider/cart.dart';
import 'package:fourth_project/provider/products_provider.dart';
import 'package:fourth_project/screen/cart_screen.dart';
import 'package:fourth_project/widget/app_drawer.dart';
import 'package:provider/provider.dart';
import '../widget/products_grid.dart';
import '../widget/badge.dart';

enum FavoriteNot {
  Favorite,
  All,
}

class ProduckOverviewScreen extends StatefulWidget {
  @override
  _ProduckOverviewScreenState createState() => _ProduckOverviewScreenState();
}

class _ProduckOverviewScreenState extends State<ProduckOverviewScreen> {
  var _showOnlyfavorite = false;
  var _isLoading = false;

  @override
  void initState() {
    setState(() {
      _isLoading = true;
    });
    Provider.of<ProductsProvider>(context, listen: false)
        .fetchProduct()
        .then((value) {
      setState(() {
        _isLoading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MyShop'),
        actions: [
          PopupMenuButton(
            onSelected: (FavoriteNot selectedValue) {
              setState(() {
                if (selectedValue == FavoriteNot.Favorite) {
                  _showOnlyfavorite = true;
                } else {
                  _showOnlyfavorite = false;
                }
                // print(_showOnlyfavorite);
              });
            },
            icon: Icon(Icons.more_vert),
            itemBuilder: (_) => [
              PopupMenuItem(
                child: Text('Favorite'),
                value: FavoriteNot.Favorite,
              ),
              PopupMenuItem(
                child: Text('All'),
                value: FavoriteNot.All,
              ),
            ],
          ),
          Consumer<Cart>(
            builder: (_, valCart, ch) => Badge(
              child: ch,
              value: valCart.itemCount.toString(),
            ),
            child: IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {
                Navigator.of(context).pushNamed(CartScreen.routeName);
              },
            ),
          )
        ],
      ),
      drawer: AppDrawer(),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ProductsGrid(_showOnlyfavorite),
    );
  }
}
