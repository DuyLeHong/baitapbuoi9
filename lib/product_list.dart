import 'package:baitapbuoi5/Models/product_list_controller.dart';
import 'package:baitapbuoi5/Models/total_cartitem.dart';
import 'package:baitapbuoi5/detail_product.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Models/product_model.dart';
import 'cart.dart';

class ProductList extends StatefulWidget {
  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  @override
  Widget build(BuildContext context) {
    print('hoan.dv: build product list');

    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text('MyShop'),
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {},
          ),
          Stack(
            children: [
              Center(
                child: IconButton(
                  icon: const Icon(
                    Icons.shopping_cart,
                    color: Colors.white,
                  ),
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CartPage()),
                  ).then((_) {
                    // This block runs when you have returned back to the 1st Page from 2nd.
                    setState(() {
                      // Call setState to refresh the page.
                    });
                  }),
                ),
              ),
              Positioned(
                right: 10,
                top: 12,
                child: Container(
                  alignment: Alignment.center,
                  height: 15,
                  width: 15,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: Colors.purple),
                  child: Consumer<CartTotal>(
                    builder: (_, cart, __) {
                      print('hoan.dv: show current count in cart');

                      return Text(
                        '${cart.count}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {},
        ),
      ),
      body: Consumer<ProductListController>(
        builder: (_, productListController, __) {
          print('build list product');

          final productList = context.read<ProductListController>().productList;
          return GridView(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: MediaQuery.of(context).size.width > 600 ? 3 : 2,
                childAspectRatio: 3 / 2),
            children: [
              for (int i = 0; i < productList.length; i++)
                ChangeNotifierProvider.value(
                  value: productList[i],
                  builder: (_, __) {
                    print('hoan.dv: build a product');

                    final product = productList[i];
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProductsDetail(product),
                          ),
                        );
                      },
                      child: Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.all(8),
                        child: Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(16.0),
                              child: Image.network(
                                product.image,
                                width:
                                    MediaQuery.of(context).size.width / 2 - 16,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.7),
                                  borderRadius: const BorderRadius.only(
                                      bottomLeft: Radius.circular(16.0),
                                      bottomRight: Radius.circular(16.0))),
                              height: 50,
                              child: Row(
                                children: [
                                  Selector<Product, bool>(
                                    builder: (_, favorite, __) {
                                      print('hoan.dv: change favorite');

                                      return IconButton(
                                        icon: Icon(
                                          product.favorite
                                              ? Icons.favorite
                                              : Icons.favorite_border,
                                          color: Color(0xFF9F28B4),
                                        ),
                                        onPressed: () {
                                          product.changeFavorite();
                                        },
                                      );
                                    },
                                    selector: (_, product) => product.favorite,
                                  ),
                                  Expanded(
                                    child: Text(
                                      productList[i].title,
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontStyle: FontStyle.normal,
                                          fontSize: 14),
                                    ),
                                    flex: 1,
                                  ),
                                  IconButton(
                                    icon: const Icon(
                                      Icons.shopping_cart,
                                      color: Color(0xFF9F28B4),
                                    ),
                                    onPressed: () {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text('Đã thêm vào giỏ hàng'),
                                        ),
                                      );
                                      // setState(() {
                                      context
                                          .read<CartTotal>()
                                          .addToCart(productList[i]);
                                      // });
                                    },
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
            ],
          );
        },
      ),
    ));
  }
}
