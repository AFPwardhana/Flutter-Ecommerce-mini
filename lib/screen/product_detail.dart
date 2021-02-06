import 'package:flutter/material.dart';
import 'package:fourth_project/provider/products_provider.dart';
import 'package:provider/provider.dart';

class ProductDetailScreen extends StatelessWidget {
  static const routeName = '/product-detail';

  // final String title;
  // ProductDetailScreen(this.title);
  @override
  Widget build(BuildContext context) {
    final idItem = ModalRoute.of(context).settings.arguments as String;
    final detailProduct = Provider.of<ProductsProvider>(
      context,
      listen: false,
    ).findById(idItem);
    return Scaffold(
      appBar: AppBar(
        title: Text(detailProduct.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 300,
              width: double.infinity,
              child: Hero(
                tag: detailProduct.id,
                child: Image.network(
                  detailProduct.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              '\$${detailProduct.price}',
              style: TextStyle(
                color: Colors.grey[800],
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              width: double.infinity,
              child: Text(
                detailProduct.description,
                textAlign: TextAlign.center,
                softWrap: true,
              ),
            )
          ],
        ),
      ),
    );
  }
}
