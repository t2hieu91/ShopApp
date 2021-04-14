import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Product({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.price,
    @required this.imageUrl,
    this.isFavorite = false,
  });

  void _setFavorite(bool newStatus) {
    isFavorite = newStatus;
    notifyListeners();
  }

  Future<void> toggleFavoriteStatus(String token, String userID) async {
    final oldValue = isFavorite;
    isFavorite = !isFavorite;
    notifyListeners();

    final url =
        'https://flutter-shopapp-a18c8-default-rtdb.firebaseio.com/userFavorites/$userID/$id.json?auth=$token';

    try {
      final response = await http.put(
        url,
        body: json.encode(
          isFavorite,
        ),
      );
      if (response.statusCode >= 400) {
        _setFavorite(oldValue);
      }
    } catch (error) {
      _setFavorite(oldValue);
    }
  }
}
