import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../model/product.dart';

class ProductsProvider with ChangeNotifier {
  final List<Product> _items = [
    Product(
      id: 'p1',
      title: 'Red Shirt',
      description: 'A red shirt - it is pretty red!',
      price: 29.99,
      imageUrl:
          'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    ),
    Product(
      id: 'p2',
      title: 'Trousers',
      description: 'A nice pair of trousers.',
      price: 59.99,
      imageUrl:
          'https://kmd-assets.imgix.net/catalog/product/1/4/14870_flightpants_a_902.jpg',
    ),
    Product(
      id: 'p3',
      title: 'Yellow Scarf',
      description: 'Warm and cozy - exactly what you need for the winter.',
      price: 19.99,
      imageUrl:
          'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    ),
    Product(
      id: 'p4',
      title: 'A Pan',
      description: 'Prepare any meal you want.',
      price: 49.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    ),
  ];

  List<Product> get items {
    return [..._items];
  }

  Product findById(String id) {
    return _items.firstWhere((element) => element.id == id);
  }

  List<Product> get favoriteItems {
    return _items.where((element) => element.isfavorite).toList();
  }

  Future<void> addProduct(Product value) {
    const url =
        'https://flutter-update-bfe9c-default-rtdb.firebaseio.com/products.json';
    return http
        .post(
      url,
      body: json.encode(
        {
          'title': value.title,
          'imageUrl': value.imageUrl,
          'description': value.description,
          'price': value.price,
          'isFavorite': value.isfavorite,
        },
      ),
    )
        .then((res) {
      final newProduct = Product(
        id: json.decode(res.body)['name'],
        imageUrl: value.imageUrl,
        description: value.description,
        price: value.price,
        title: value.title,
      );
      _items.add(newProduct);
      notifyListeners();
    }).catchError((onError) {
      print(onError);
      throw onError;
    });
  }

  void updateProduct(String id, Product newProduct) {
    final proIndex = _items.indexWhere((element) => element.id == id);
    if (proIndex >= 0) {
      _items[proIndex] = newProduct;
      notifyListeners();
    }
  }

  void deteleProduct(String id) {
    _items.removeWhere((element) => element.id == id);
    notifyListeners();
  }
}
