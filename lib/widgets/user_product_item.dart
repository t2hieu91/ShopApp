import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../screens/edit_product_screen.dart';
import '../providers/products.dart';

class UserProductItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;

  UserProductItem(
    this.id,
    this.title,
    this.imageUrl,
  );

  void _deleteProductItem(BuildContext ctx) {
    final scaffold = Scaffold.of(ctx);

    showDialog(
      context: ctx,
      builder: (ctx) => Platform.isIOS
          ? CupertinoAlertDialog(
              title: Text('Are you sure ?'),
              content: Text('Do you want to remove the item from the cart ?'),
              actions: [
                CupertinoDialogAction(
                  isDestructiveAction: true,
                  child: Text('No'),
                  onPressed: () {
                    Navigator.of(ctx).pop(false);
                  },
                ),
                CupertinoDialogAction(
                  child: Text('Yes'),
                  onPressed: () async {
                    Navigator.of(ctx).pop(true);

                    try {
                      await Provider.of<Products>(
                        ctx,
                        listen: false,
                      ).deleteProduct(id);
                    } catch (error) {
                      scaffold.showSnackBar(
                        SnackBar(
                            content: Text(
                          'Deleting failed !',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 20.0),
                        )),
                      );
                    }
                  },
                ),
              ],
            )
          : AlertDialog(
              title: Text('Are you sure ?'),
              content: Text('Do you want to remove the item from the cart ?'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(ctx).pop(false);
                  },
                  child: Text('No'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(ctx).pop(true);
                    Provider.of<Products>(
                      ctx,
                      listen: false,
                    ).deleteProduct(id);
                  },
                  child: Text('Yes'),
                ),
              ],
            ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imageUrl),
      ),
      trailing: Container(
        width: 100,
        child: Row(
          children: [
            IconButton(
              icon: Icon(Icons.edit),
              color: Theme.of(context).primaryColor,
              onPressed: () {
                Navigator.of(context).pushNamed(
                  EditProductScreen.routeName,
                  arguments: id,
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.delete),
              color: Theme.of(context).errorColor,
              onPressed: () => _deleteProductItem(context),
            ),
          ],
        ),
      ),
    );
  }
}
