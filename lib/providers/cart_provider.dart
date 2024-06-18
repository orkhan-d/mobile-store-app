import 'package:flutter/material.dart';
import 'package:store/services/cart_service.dart';
import 'package:store/services/products_service.dart';

class CartProvider extends ChangeNotifier {
  List<Cart> cart = [];
  bool isLoading = false;

  CartProvider() {
    updateCart();
  }

  updateCart() {
    isLoading = true;
    notifyListeners();
    getUserCartAPI().then((value) {
      cart = value;
      isLoading = false;
      notifyListeners();
    });
  }

  addProductToCart(Product product) async {
    await addProductToCartAPI(product);
    int index = cart.indexWhere((e) => e.product.id==product.id);
    if (index!=-1) {
      cart[index].amount += 1;
    }
    else {
      cart.add(Cart(
      product: product,
      amount: 1,
    ));
    }
    notifyListeners();
  }

  removeProductFromCart(Product product) async {
    await removeProductFromCartAPI(product);
    cart = cart.where((e) => e.product.id!=product.id).toList();
    notifyListeners();
  }

  clearCart() async {
    await clearCartAPI();
    cart = [];
    notifyListeners();
  }

  reduceProductAmountInCart(Product product) async {
    await reduceProductInCartAPI(product);
    int index = cart.indexWhere((e) => e.product.id==product.id);
    if (index!=-1) {
      cart[index].amount -= 1;
      if (cart[index].amount==0) {
        cart = cart.where((e) => e.product.id!=product.id).toList();
      }
      notifyListeners();
    }
  }
}