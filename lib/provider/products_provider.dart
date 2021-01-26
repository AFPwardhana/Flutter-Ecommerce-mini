import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fourth_project/model/http_exception.dart';
import 'package:http/http.dart' as http;
import '../model/product.dart';

class ProductsProvider with ChangeNotifier {
  List<Product> _items = [
    // Product(
    //   id: 'p1',
    //   title: 'Red Shirt',
    //   description: 'A red shirt - it is pretty red!',
    //   price: 29.99,
    //   imageUrl:
    //       'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    // ),
    // Product(
    //   id: 'p2',
    //   title: 'Trousers',
    //   description: 'A nice pair of trousers.',
    //   price: 59.99,
    //   imageUrl:
    //       'https://kmd-assets.imgix.net/catalog/product/1/4/14870_flightpants_a_902.jpg',
    // ),
    // Product(
    //   id: 'p3',
    //   title: 'Yellow Scarf',
    //   description: 'Warm and cozy - exactly what you need for the winter.',
    //   price: 19.99,
    //   imageUrl:
    //       'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    // ),
    // Product(
    //   id: 'p4',
    //   title: 'A Pan',
    //   description: 'Prepare any meal you want.',
    //   price: 49.99,
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    // ),
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

  Future<void> fetchProduct() async {
    final url =
        'https://flutter-update-bfe9c-default-rtdb.firebaseio.com/products.json';
    try {
      final response = await http.get(url);
      // print(json.decode(response.body));
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      final List<Product> loadedProduct = [];
      if (extractedData == null) {
        return;
      }
      extractedData.forEach((prodId, prodData) {
        // print(prodData['isFavorite']);
        loadedProduct.add(
          Product(
            id: prodId,
            title: prodData['title'],
            description: prodData['description'],
            price: prodData['price'],
            imageUrl: prodData['imageUrl'],
            isfavorite: prodData['isFavorite'],
          ),
        );
      });
      _items = loadedProduct;
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<void> addProduct(Product product) async {
    final url =
        'https://flutter-update-bfe9c-default-rtdb.firebaseio.com/products.json';
    try {
      final response = await http.post(
        url,
        body: json.encode(
          {
            'title': product.title,
            'imageUrl': product.imageUrl,
            'description': product.description,
            'price': product.price,
            'isFavorite': product.isfavorite,
          },
        ),
      );

      final newProduct = Product(
        id: json.decode(response.body)['name'],
        imageUrl: product.imageUrl,
        description: product.description,
        price: product.price,
        title: product.title,
      );
      _items.add(newProduct);
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<void> updateProduct(String id, Product newProduct) async {
    final proIndex = _items.indexWhere((element) => element.id == id);
    final url =
        'https://flutter-update-bfe9c-default-rtdb.firebaseio.com/products/$id.json';
    if (proIndex >= 0) {
      await http.patch(url,
          body: json.encode({
            'title': newProduct.title,
            'description': newProduct.description,
            'imageUrl': newProduct.imageUrl,
            'price': newProduct.price,
          }));
      _items[proIndex] = newProduct;
      notifyListeners();
    }
  }

  Future<void> deteleProduct(String id) async {
    final url =
        'https://flutter-update-bfe9c-default-rtdb.firebaseio.com/products/$id.json';
    final existingProductIndex =
        _items.indexWhere((element) => element.id == id);
    var existingProduct = _items[existingProductIndex];
    _items.removeAt(existingProductIndex);
    notifyListeners();

    final response = await http.delete(url);
    if (response.statusCode >= 400) {
      _items.insert(existingProductIndex, existingProduct);
      notifyListeners();
      throw HttpException('Could not delete');
    }
    existingProduct = null;
  }
}
