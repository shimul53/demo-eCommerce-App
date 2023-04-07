import 'package:demo_ecommerce_app/controllers/products/product_controller.dart';
import 'package:demo_ecommerce_app/model/product_model.dart';
import 'package:flutter/material.dart';

import '../controllers/categories/categories_controller.dart';


class ProductDetails extends StatefulWidget {
   final ProductsController productsController;


   ProductDetails({required this.productsController});



  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {

 int index =0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(productsController.products[index]["title"],),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Image.network(productsController.products[index]["image"]),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  productsController.products[index]['title'],
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  productsController.products[index]["description"],
                  style: TextStyle(fontSize: 16.0),
                ),
                SizedBox(height: 8.0),
                Text(
                  "\$${productsController.products[index]["price"]}",
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}