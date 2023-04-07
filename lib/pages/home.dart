import 'dart:io';

import 'package:demo_ecommerce_app/pages/cart.dart';
import 'package:demo_ecommerce_app/pages/product_details.dart';
import 'package:demo_ecommerce_app/pages/profile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/categories/categories_controller.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  CategoriesController categoriesController = CategoriesController();
  File? _imageFile;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _buildAppBar(),
        backgroundColor: Colors.grey[100],
        body: Obx(() {

          if (categoriesController.loading.value) {
            return const Center(child: CircularProgressIndicator());
          }
          if (categoriesController.categories.isEmpty) {
            return const Center(child: Text("No categories found"));
          }
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
              const Text("Categories",textAlign:TextAlign.start,style: TextStyle(
              fontWeight: FontWeight.bold,fontSize: 16.0,
            ),),

                _buildCategoriesRow(),

              SizedBox(height: 20.0),
                const Text("Products",textAlign:TextAlign.start,style: TextStyle(
                fontWeight: FontWeight.bold,fontSize: 16.0,
              ),),
                SizedBox(height: 10.0),
                Expanded(
                  child: Obx(
                        () {
                      if (productsController.loading.value) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (productsController.products.isEmpty) {
                        return const Center(child: Text("No products found"));
                      }
                      if (productsController.showGrid.value) {
                        return GridView.builder(
                          padding: const EdgeInsets.only(top: 16),
                          gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.7,
                          ),
                          itemCount: productsController.products.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Card(
                              elevation: 0.0,
                              child: Container(
                                height: 150,
                                padding: const EdgeInsets.all(16),
                                margin: const EdgeInsets.only(bottom: 8.0),
                                child: Column(
                                  children: [
                                    Container(
                                      height: 100,
                                      width: 100,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: NetworkImage(productsController
                                              .products[index]["image"]),
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              productsController.products[index]
                                              ["title"],
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            Expanded(
                                              child: Text(
                                                productsController
                                                    .products[index]
                                                ["description"],
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            Text(
                                              "\$${productsController.products[index]["price"]}",
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      }
                      return _buildProductsList();
                    },
                  ),
                ),
              ],
            ),
          );
        }));
  }

  ListView _buildProductsList() {
    return ListView.builder(
      itemCount: productsController.products.length,
      padding: const EdgeInsets.only(top: 16),
      itemBuilder: (context, index) => Card(
        elevation: 0.0,
        child: GestureDetector(
          onTap: (){
            Navigator.of(context).push(MaterialPageRoute(
            builder: (context) =>  ProductDetails(productsController: productsController,),
            ));
          },
          child: Container(
            height: 120,
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.only(bottom: 8.0),
            child: Row(
              children: [
                Container(
                  width: 100,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                          productsController.products[index]["image"]),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          productsController.products[index]["title"],
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Expanded(
                          child: Text(
                            productsController.products[index]["description"],
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Text(
                          "\$${productsController.products[index]["price"]}",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }



  Container _buildCategoriesRow() {
    return Container(
      height: 230.0,
      margin: const EdgeInsets.only(top: 16),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.5,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          // Set the number of columns in the grid
        ),
        itemCount: categoriesController.categories.length,
        itemBuilder: (context, index) => Obx(
              () => InkWell(
            onTap: () {
              categoriesController.changeCategories(index);
            },
            child: Container(
              margin: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4.0),
                color: index == categoriesController.currentIndex.value
                    ? Colors.grey[900]
                    : Colors.grey[200],
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8.0,
              ),
              child: Center(
                child: Text(
                  categoriesController.categories[index],
                  style: TextStyle(
                    color: index == categoriesController.currentIndex.value
                        ? Colors.white
                        : Colors.black,
                  ),
                ),
              ),
            ),
          ),
        ),
      )

    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,

      iconTheme: const IconThemeData(color: Colors.black),

      elevation: 0,
      title: const Text(
        "eCommerceApp",
        style: TextStyle(color: Colors.black),
      ),
      actions: [


        IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const CartPage(),
              ));
            },
            icon: const Icon(Icons.shopping_cart_outlined)),

          GestureDetector(
            onTap: (){
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const ProfilePage(),
              ));
            },
            child:  Icon(Icons.account_circle_outlined),
          ),
          SizedBox(width: 20,)

      ],
    );
  }
}