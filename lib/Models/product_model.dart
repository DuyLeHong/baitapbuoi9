import 'package:flutter/cupertino.dart';

class Product extends ChangeNotifier {
  String title;
  String image;
  double price;
  String description;
  bool favorite;

  Product(this.title, this.image, this.price, this.description, this.favorite);

  void changeFavorite() {
    favorite = !favorite;

    notifyListeners();
  }
}
