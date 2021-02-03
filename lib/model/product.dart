import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isfavorite;

  Product({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.price,
    @required this.imageUrl,
    this.isfavorite = false,
  });
  void _setFavValue(oldStatus) {
    isfavorite = oldStatus;
    notifyListeners();
  }

  Future<void> favoriteHandler(String authToken, String userId) async {
    final oldStatus = isfavorite;
    final url =
        'https://flutter-update-bfe9c-default-rtdb.firebaseio.com/userFavorite/$userId/$id.json?auth=$authToken';
    isfavorite = !isfavorite;
    notifyListeners();
    try {
      final response = await http.put(
        url,
        body: json.encode(
          isfavorite,
        ),
      );
      if (response.statusCode >= 400) {
        _setFavValue(oldStatus);
      }
    } catch (error) {
      _setFavValue(oldStatus);
    }
  }
}
