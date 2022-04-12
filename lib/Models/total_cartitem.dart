import 'package:baitapbuoi5/Models/cart_model.dart';
import 'package:baitapbuoi5/Models/product_model.dart';
import 'package:flutter/material.dart';

class CartTotal extends ChangeNotifier {
  List<CartItems> cartItemsList = [];

  double get total {
    return cartItemsList.fold(0.0,
        (double currentTotal, CartItems nextCartItem) {
      return currentTotal + nextCartItem.total;
    });
  }

  int get count {
    return cartItemsList.fold(0, (int currentCount, CartItems nextCartItem) {
      return currentCount + nextCartItem.count;
    });
  }

  void addFullToCart(CartItems cartItem) {
    bool isAdd = false;
    if (cartItemsList.length == 0) {
      cartItemsList.add(cartItem);
    } else {
      for (int i = 0; i < cartItemsList.length; i++) {
        if (cartItem.product == cartItemsList[i].product) {
          cartItemsList[i].addCountNum(cartItem.count);
          isAdd = true;
          break;
        }
      }
      if (!isAdd) {
        cartItemsList.add(cartItem);
      }

      notifyListeners();
    }
  }

  void addListToCart(CartTotal cartTotal) {
    if (cartTotal.cartItemsList == 0) {
    } else {
      for (int i = 0; i < cartTotal.cartItemsList.length; i++) {
        cartItemsList.add(cartTotal.cartItemsList[i]);
      }
    }
  }

  void deleteFromCart(CartItems cartItem) {
    bool isDeleted = false;
    if (cartItemsList.length == 0) {
    } else {
      for (int i = 0; i < cartItemsList.length; i++) {
        if (cartItem.product == cartItemsList[i].product) {
          cartItemsList.remove(cartItem);
          isDeleted = true;
          break;
        }
      }
      if (!isDeleted) {}
    }
  }

  void addToCart(Product product) {
    bool isAdd = false;
    if (cartItemsList.length == 0) {
      CartItems cartItem = CartItems(product: product, count: 1);
      cartItemsList.add(cartItem);
    } else {
      for (int i = 0; i < cartItemsList.length; i++) {
        if (product == cartItemsList[i].product) {
          cartItemsList[i].addcount();
          isAdd = true;
          break;
        }
      }
      if (!isAdd) {
        CartItems cartItem = CartItems(product: product, count: 1);
        cartItemsList.add(cartItem);
      }
    }

    notifyListeners();
  }

  void subItemCart(Product product) {
    for (int i = 0; i < cartItemsList.length; i++) {
      if (product == cartItemsList[i].product) {
        if (cartItemsList[i].count <= 1) {
          cartItemsList.remove(cartItemsList[i]);
        } else {
          cartItemsList[i].subcount();
        }
      }
    }
  }

  void removeFromCart(CartItems cartItem) {
    cartItemsList.remove(cartItem);
  }

  void deleteAllFromCloneCart(
      CartTotal cartTotal, BuildContext context, Function() refesh) async {
    int count = 0;
    if (cartItemsList.length == 0 || cartTotal.cartItemsList.length == 0) {
    } else {
      for (int i = 0; i < cartTotal.cartItemsList.length; i++) {
        for (int j = 0; j < cartItemsList.length; j++) {
          if (cartTotal.cartItemsList[i] == cartItemsList[j]) {
            count++;
            cartItemsList.remove(cartTotal.cartItemsList[i]);
          }
        }
      }
      ScaffoldMessenger.of(context).clearSnackBars();
      if (count != 0) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Đã xóa $count loại sản phẩm khỏi giỏ hàng'),
            duration: const Duration(seconds: 2),
            action: SnackBarAction(
              label: 'Khôi phục',
              onPressed: () {
                cartProduct.addListToCart(cartProductDeleted);
                cartProductDeleted.cartItemsList.clear();
                refesh();
              },
            ),
          ),
        );
      }
      await Future.delayed(Duration(seconds: 5));
      cartProductDeleted.cartItemsList.clear();
    }
  }
}

late CartTotal cartProduct = CartTotal();

late CartTotal cartProductDeleted = CartTotal();
