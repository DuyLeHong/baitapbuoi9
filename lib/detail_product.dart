import 'package:baitapbuoi5/Models/product_model.dart';
import 'package:flutter/material.dart';

class ProductsDetail extends StatelessWidget {
  Product product;

  ProductsDetail(this.product);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            child: Stack(children: [
              Image.network(product.image),
              Positioned(
                top: 30,
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                ),
              ),
              Positioned(
                bottom: 20,
                left: 50,
                child: Text(
                  product.title,
                  style: TextStyle(color: Colors.white, fontSize: 30),
                ),
              ),
            ]),
          ),
          SizedBox(
            height: 10,
          ),
          Center(
            child: Text(
              product.price.toString() + ' \$',
              style: TextStyle(fontSize: 20, color: Colors.grey),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Center(
            child: Text(
              product.description,
              style: TextStyle(fontSize: 15),
            ),
          ),
        ],
      )),
    );
  }
}
