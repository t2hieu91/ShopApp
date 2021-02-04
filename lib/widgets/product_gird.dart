import 'package:flutter/material.dart';

import '../models/product.dart';
import './product_item.dart';

class ProductGird extends StatelessWidget {
  const ProductGird({
    Key key,
    @required this.loadedProducts,
  }) : super(key: key);

  final List<Product> loadedProducts;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(10.0),
      itemCount: loadedProducts.length,
      itemBuilder: (context, index) => ProductItem(
        loadedProducts[index].id,
        loadedProducts[index].title,
        loadedProducts[index].imageUrl,
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 15,
        childAspectRatio: 3 / 2,
        mainAxisSpacing: 15,
      ),
    );
  }
}
