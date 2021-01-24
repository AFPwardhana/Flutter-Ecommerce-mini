import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widget/puduct_item.dart';
import '../provider/products_provider.dart';

class ProductsGrid extends StatelessWidget {
  final bool filterFavorite;
  ProductsGrid(this.filterFavorite);
  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<ProductsProvider>(context);
    final loadedProduct =
        filterFavorite ? productsData.favoriteItems : productsData.items;

    // print(filterFavorite);

    return GridView.builder(
      padding: EdgeInsets.all(10),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (ctx, index) {
        return ChangeNotifierProvider.value(
          value: loadedProduct[index],
          child: ProductItem(),
        );
      },
      itemCount: loadedProduct.length,
    );
  }
}
