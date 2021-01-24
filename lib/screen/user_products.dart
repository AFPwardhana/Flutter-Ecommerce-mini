import 'package:flutter/material.dart';
import 'package:fourth_project/provider/products_provider.dart';
import 'package:fourth_project/screen/edit_product_screen.dart';
import 'package:fourth_project/widget/app_drawer.dart';
import 'package:fourth_project/widget/user_product_item.dart';
import 'package:provider/provider.dart';

class UserProductScreen extends StatelessWidget {
  static const routeName = '/user-product';
  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<ProductsProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Products'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(EditProductsScreen.routeName);
            },
          )
        ],
      ),
      drawer: AppDrawer(),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: ListView.builder(
          itemCount: productData.items.length,
          itemBuilder: (_, index) => Column(
            children: [
              UserProductItem(
                productData.items[index].id,
                productData.items[index].title,
                productData.items[index].imageUrl,
                productData.deteleProduct,
              ),
              Divider(),
            ],
          ),
        ),
      ),
    );
  }
}
