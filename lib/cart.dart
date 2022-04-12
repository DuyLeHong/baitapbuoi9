import 'package:baitapbuoi5/Models/total_cartitem.dart';
import 'package:baitapbuoi5/cart_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CartPage extends StatefulWidget {
  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  late bool isDeleteClicked = false;

  refresh() {
    setState(() {});
  }

  onRestore() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Your Cart'),
          backgroundColor: Colors.purple,
          // leading: IconButton(
          //   icon: Icon(Icons.arrow_back),
          //   onPressed: () {
          //     Navigator.pop(context,
          //         MaterialPageRoute(builder: (context) => ProductList()));
          //   },
          // ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Container(
                height: 70,
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
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text(
                        'Total',
                        style: TextStyle(fontSize: 16),
                      ),
                      Spacer(),
                      Container(
                        alignment: Alignment.centerRight,
                        child: Container(
                          child: Row(
                            children: [
                              Container(
                                height: 30,
                                width: 60,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Colors.purple),
                                child: Text(
                                  '\$' + cartProduct.total.toStringAsFixed(2),
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.white54),
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Container(
                                height: 40,
                                width: 100,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Colors.purple),
                                child: Text(
                                  'ORDER NOW',
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.white),
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    isDeleteClicked = !isDeleteClicked;
                                    cartProduct.deleteAllFromCloneCart(
                                        cartProductDeleted, context, onRestore);
                                  });
                                },
                                style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.white),
                                    side: MaterialStateProperty.all(BorderSide(
                                        color: Colors.red,
                                        width: 2.0,
                                        style: BorderStyle.solid))),
                                child: isDeleteClicked
                                    ? Text(
                                        'Delete selected',
                                        style: TextStyle(color: Colors.red),
                                      )
                                    : Text(
                                        'Delete',
                                        style: TextStyle(color: Colors.red),
                                      ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                height: MediaQuery.of(context).size.height - 250,
                child: ListView.separated(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: cartProduct.cartItemsList.length,
                  itemBuilder: (BuildContext context, int index) {
                    final item = cartProduct.cartItemsList[index];
                    return Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Dismissible(
                        key: UniqueKey(),
                        onDismissed: (direction) {
                          setState(() {
                            cartProduct.removeFromCart(
                                cartProduct.cartItemsList[index]);
                          });
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content:
                                  Text('${item.product.title} đã bị xóa')));
                        },
                        child: CartItem(cartProduct.cartItemsList[index], index,
                            refresh, isDeleteClicked),
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) =>
                      const SizedBox(
                    height: 5,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
