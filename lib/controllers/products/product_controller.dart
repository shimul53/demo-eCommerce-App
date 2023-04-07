import 'package:demo_ecommerce_app/controllers/products/product_repo.dart';
import 'package:get/get.dart';

class ProductsController extends GetxController {
  ProductsRepository productsRepository = ProductsRepository();
  List products = [].obs;
  var showGrid = false.obs;
  var loading = false.obs;

  loadProductsFromRepo(String categoryName) async {
    loading(true);
    products = await productsRepository.loadProductsFromApi(categoryName);
    loading(false);
  }

  toggleGrid() {
    showGrid(!showGrid.value);
  }
}
