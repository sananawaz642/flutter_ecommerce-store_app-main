import 'package:get/get.dart';

import '../model/product.dart';

class CartController extends GetxController {
  var cartItems = <Product>[].obs;
  var totalPrice = 0.0.obs;

  void addToCart(Product product) {
    cartItems.add(product);
    calculateTotal();
  }

  void removeFromCart(Product product) {
    cartItems.remove(product);
    calculateTotal();
  }

  void calculateTotal() {
    totalPrice.value = cartItems.fold(0, (sum, item) => sum + item.price);
  }
}