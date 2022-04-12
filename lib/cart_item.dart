import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Models/cart_model.dart';
import 'Models/total_cartitem.dart';

class CartItem extends StatefulWidget {
  final int index;
  final CartItems cartItems;
  final Function() notifyParent;
  final bool isSelected;

  CartItem(this.cartItems, this.index, this.notifyParent, this.isSelected);

  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  bool isChecked = false;

  void _increaseCount() {
    setState(() {
      cartProduct.cartItemsList[widget.index].addcount();
      widget.notifyParent();
    });
  }

  void _decreaseCount() {
    setState(() {
      if (cartProduct.cartItemsList[widget.index].count <= 1) {
        cartProduct.removeFromCart(cartProduct.cartItemsList[widget.index]);
      } else {
        cartProduct.cartItemsList[widget.index].subcount();
      }
      widget.notifyParent();
    });
  }

  void _addDeletedList() {
    if (isChecked) {
      cartProductDeleted.addFullToCart(widget.cartItems);
    } else {
      cartProductDeleted.deleteFromCart(widget.cartItems);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: MediaQuery.of(context).size.width - 30,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            spreadRadius: 1,
            blurRadius: 2,
            offset: Offset(0, 1),
            color: Colors.black.withOpacity(0.2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Row(
          children: [
            Container(
              child: widget.isSelected
                  ? Checkbox(
                      onChanged: (bool? value) {
                        setState(() {
                          isChecked = value!;
                          _addDeletedList();
                        });
                      },
                      value: isChecked,
                    )
                  : Text(''),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 50,
                width: 50,
                child: CircleAvatar(
                  backgroundColor: Colors.purple,
                  child: Text(
                    '\$' + widget.cartItems.product.price.toStringAsFixed(2),
                    style: TextStyle(fontSize: 12),
                  ),
                ),
              ),
            ),
            Container(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        widget.cartItems.product.title,
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Total: \$' +
                            '${widget.cartItems.total.toStringAsFixed(2)}',
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Spacer(),
            Row(
              children: [
                IconButton(
                  onPressed: _decreaseCount,
                  icon: Icon(
                    Icons.remove,
                    color: Colors.red,
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(4),
                  alignment: Alignment.centerRight,
                  child: Text(
                    'x${widget.cartItems.count}',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                IconButton(
                  onPressed: _increaseCount,
                  icon: Icon(
                    Icons.add,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
