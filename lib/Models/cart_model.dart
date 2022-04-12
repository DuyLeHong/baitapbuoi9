import 'package:baitapbuoi5/Models/product_model.dart';

class CartItems {
  Product product;
  int count;
  double _total = 0;

  double get total => _total;

  CartItems({required this.product, required this.count}) {
    _total = product.price * count;
  }

  void addcount() {
    count = count + 1;
    _total = _total + product.price;
  }

  void addCountNum(int num) {
    count = count + num;
    _total = _total + product.price * num;
  }

  void subcount() {
    count = count - 1;
    _total = _total - product.price;
  }
}
