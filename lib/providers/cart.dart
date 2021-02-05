import 'package:flutter/foundation.dart';

class CartItem {
  final String id;
  final String title;
  final int quality;
  final double price;

  CartItem({
    @required this.id,
    @required this.title,
    @required this.quality,
    @required this.price,
  });
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  int get itemCount {
    return _items.length;
  }

  void addItem(
    String productId,
    String title,
    double price,
  ) {
    if (_items.containsKey(productId)) {
      // change quality ...
      _items.update(
        productId,
        (oldValue) => CartItem(
          id: oldValue.id,
          title: oldValue.title,
          price: oldValue.price,
          quality: oldValue.quality + 1,
        ),
      );
    } else {
      // add new item ...
      _items.putIfAbsent(
        productId,
        () => CartItem(
          id: DateTime.now().toString(),
          title: title,
          price: price,
          quality: 1,
        ),
      );
    }
    notifyListeners();
  }
}
